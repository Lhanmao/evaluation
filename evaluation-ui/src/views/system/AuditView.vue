<template>
    <div>
        <div>
            <div style="margin-bottom: 15px;">
                <el-input v-model="params.name" style="width: 200px;" placeholder="请输入发布人名称"
                    @change="findBySearch()"></el-input>
                <el-input v-model="params.title" style="width: 200px;" placeholder="请输入发布文章标题"
                    @change="findBySearch()"></el-input>
                <el-button type="warning" round style="margin-left:5px" @click="findBySearch()">查询</el-button>
                <el-button type="warning" round style="margin-left:5px" @click="reset()">重置</el-button>
            </div>
            <div>
                <el-table :data="tableData" height="300" border style="width: 100%">
                    <el-table-column prop="audit_content" label="审核状态" width="105px">
                        <template v-slot="scope">
                            <el-tag type="success" v-if="scope.row.audit_content == '审核通过'">
                                {{ scope.row.audit_content }}</el-tag>
                            <el-tag type="info" v-else-if="scope.row.audit_content == '未审核'">{{ scope.row.audit_content
                                }}</el-tag>
                            <el-tag type="danger" v-else>{{ scope.row.audit_content }}</el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column prop="user_name" label="发布人" width="90px">
                    </el-table-column>
                    <el-table-column prop="title" label="文章标题">
                    </el-table-column>
                    <el-table-column prop="descr" label="文章简介">
                    </el-table-column>
                    <el-table-column prop="tags" label="文章标签" width="90px">
                        <template v-slot="scope">
                            <el-tag v-for="tagitem in JSON.parse(scope.row.tags || '[]')" :key="tagitem"
                                style="margin-right: 5px;">{{ tagitem }}</el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column prop="date" label="发布时间">
                    </el-table-column>
                    <el-table-column label="操作">
                        <template slot-scope="scope">
                            <el-button type="primary" round @click="auditContent(scope.row)">审核</el-button>
                            <el-popconfirm title="确定删除吗？" @confirm="del(scope.row.id)">
                                <el-button slot="reference" type="danger" round style="margin-left: 5px;">删除</el-button>
                            </el-popconfirm>
                        </template>
                    </el-table-column>
                </el-table>
            </div>
            <div class="block" style="margin-top: 10px;">
                <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                    :current-page="params.pageNum" :page-sizes="[5, 10, 15, 20]" :page-size="params.pageSize"
                    layout="total, sizes, prev, pager, next, jumper" :total="total">
                </el-pagination>
            </div>
        </div>
        <div>
            <el-dialog title="审核文章" :visible.sync="dialogFormVisible">
                <el-form :model="form">
                    <el-form-item label="标题" label-width="15%">
                        <el-input v-model="form.title" autocomplete="off" style="width: 90%;"></el-input>
                    </el-form-item>
                    <el-form-item label="简介" label-width="15%">
                        <el-input v-model="form.descr" autocomplete="off" style="width: 90%;"></el-input>
                    </el-form-item>
                    <el-form-item label="标签" label-width="15%">
                        <el-tag v-for="tagitem in JSON.parse(form.tags || '[]')" :key="tagitem"
                            style="margin-right: 5px;">{{
                    tagitem }}</el-tag>
                    </el-form-item>
                    <el-form-item label="发布人" label-width="15%">
                        <el-input v-model="form.user_name" autocomplete="off" style="width: 90%;"></el-input>
                    </el-form-item>
                    <el-form-item label="内容" label-width="15%">
                        <div v-html="form.content"></div>
                    </el-form-item>
                    <el-form-item label="审核建议" label-width="15%">
                        <el-select v-model="form.audit_content" style="width: 90%;">
                            <el-option v-for="item in auditList" :key="item.id" :value="item.name"
                                :label="item.name"></el-option>
                        </el-select>
                    </el-form-item>
                </el-form>

                <div slot="footer" class="dialog-footer">
                    <el-button @click="dialogFormVisible = false">取 消</el-button>
                    <el-button type="primary" @click="submit()">确 定</el-button>
                </div>
            </el-dialog>
        </div>
    </div>
</template>

<script>
import request from '@/utils/request';

export default {
    data() {
        return {
            input: "",
            params: {//查询、分页参数
                name: '',
                pageNum: 1,
                pageSize: 5
            },
            tableData: [],
            total: 0,
            dialogFormVisible: false,
            form: {},
            showContent: '',
            auditList: [{
                id: '1',
                name: '审核通过'
            }, {
                id: '2',
                name: '审核不通过'
            }]
        }
    },
    mounted() {
        this.findBySearch();
    },
    methods: {
        //查表
        findBySearch() {
            request.get("/audit/search", {
                params: this.params
            }).then(res => {
                if (res.code === '0') {
                    this.tableData = res.data.list;
                    this.total = res.data.total;
                } else {

                }
            })
        },
        //重置查询
        reset() {
            this.params = {
                name: ''
            }
            this.params.pageSize = 5;
            this.findBySearch();
        },
        //分页功能
        handleSizeChange(pageSize) {
            this.params.pageSize = pageSize;
            this.params.pageNum = 1;
            this.findBySearch();
        },
        handleCurrentChange(pageNum) {
            this.params.pageNum = pageNum;
            this.findBySearch();
        },
        //新增功能
        add() {
            this.form = {};
            this.dialogFormVisible = true;
        },
        //提交功能
        submit() {
            request.post("/audit/add", this.form).then(res => {
                if (res.code === '0') {
                    this.$message.success("操作成功");
                    this.dialogFormVisible = false;
                    this.findBySearch();
                } else {
                    this.$message.error(res.msg)
                }
            })
        },
        // 审核功能
        auditContent(obj) {
            //编辑功能深拷贝解决表单编辑影响显示
            this.form = JSON.parse(JSON.stringify(obj));
            // this.showContent = this.form.content
            console.log(this.form)
            this.dialogFormVisible = true;
        },
        //删除功能
        del(id) {
            request.delete("/audit/delete/" + id).then(res => {
                if (res.code === '0') {
                    this.$message.success("删除成功");
                    this.findBySearch();
                } else {
                    this.$message.error(res.msg)
                }
            })
        }
    }
}
</script>