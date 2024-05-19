<template>
    <div>
        <div>
            <div style="margin-bottom: 15px;">
                <el-input v-model="params.name" style="width: 200px;" placeholder="请输入品牌名"
                    @change="findBySearch()"></el-input>
                <el-button type="warning" round style="margin-left:5px" @click="findBySearch()">查询</el-button>
                <el-button type="warning" round style="margin-left:5px" @click="reset()">重置</el-button>
                <el-button type="primary" round style="margin-left:10px" @click="add()">新增</el-button>
            </div>
            <div>
                <el-table :data="tableData" height="300" border style="width: 100%">
                    <el-table-column prop="id" label="ID" width="90px">
                    </el-table-column>
                    <el-table-column prop="name" label="品牌名">
                    </el-table-column>
                    <el-table-column label="操作">
                        <template slot-scope="scope">
                            <el-button type="primary" round @click="edit(scope.row)">编辑</el-button>
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
            <el-dialog title="填写信息" :visible.sync="dialogFormVisible">
                <el-form :model="form">
                    <el-form-item label="品牌名" label-width="15%">
                        <el-input v-model="form.name" autocomplete="off" style="width: 90%;"></el-input>
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
        }
    },
    mounted() {
        this.findBySearch();
    },
    methods: {
        //查表
        findBySearch() {
            request.get("/category/search", {
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
            request.post("/category/add", this.form).then(res => {
                if (res.code === '0') {
                    this.$message.success("操作成功");
                    this.dialogFormVisible = false;
                    this.findBySearch();
                } else {
                    this.$message.error(res.msg)
                }
            })
        },
        // 编辑功能
        edit(obj) {
            //编辑功能深拷贝解决表单编辑影响显示
            this.form = JSON.parse(JSON.stringify(obj));
            this.dialogFormVisible = true;
        },
        //删除功能
        del(id) {
            request.delete("/category/delete/" + id).then(res => {
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