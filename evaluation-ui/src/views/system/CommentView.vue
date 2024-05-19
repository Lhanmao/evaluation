<template>
    <div>
        <div>
            <div style="margin-bottom: 15px;">
                <el-input v-model="params.content" style="width: 200px;" placeholder="请输入评论内容"
                    @change="findBySearch()"></el-input>
                <el-input v-model="params.username" style="width: 200px;margin-left: 5px;" placeholder="请输入姓名"
                    @change="findBySearch()"></el-input>
                <el-button type="warning" round style="margin-left:5px" @click="findBySearch()">查询</el-button>
                <el-button type="warning" round style="margin-left:5px" @click="reset()">重置</el-button>
                <el-popconfirm title="确定批量删除吗？" @confirm="delBatch()">
                    <el-button slot="reference" type="danger" round style="margin-left: 5px;">批量删除</el-button>
                </el-popconfirm>
            </div>
            <div>
                <el-table :data="tableData" height="300" border style="width: 100%"
                    @selection-change="handleSelectionChange" ref="table" :row-key="getRowKeys">
                    <el-table-column type="selection" width="55" ref="table" :reserve-selection="true">
                    </el-table-column>
                    <el-table-column prop="title" label="文章标题">
                    </el-table-column>
                    <el-table-column prop="content" label="评论内容">
                    </el-table-column>
                    <el-table-column prop="create_time" label="评论时间">
                    </el-table-column>
                    <el-table-column prop="user_name" label="评论用户">
                    </el-table-column>
                    <el-table-column label="操作">
                        <template slot-scope="scope">
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

    </div>
</template>

<script>
import request from '@/utils/request';

export default {
    data() {
        return {
            input: "",
            params: {//查询、分页参数
                content: '',
                username: '',
                pageNum: 1,
                pageSize: 5
            },
            tableData: [],
            total: 0,
            multipleSelection: []
        }
    },
    created() {
        this.findBySearch();
    },
    methods: {
        //查表
        findBySearch() {
            request.get("/comment/search", {
                params: this.params
            }).then(res => {
                if (res.code === '0') {
                    this.tableData = res.data.list;
                    this.total = res.data.total;
                    console.log(res.data.list)
                } else {

                }
            })
        },
        //重置查询
        reset() {
            this.params = {
                content: '',
                username: ''
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
        //删除功能
        del(id) {
            request.delete("/comment/delete/" + id).then(res => {
                if (res.code === '0') {
                    this.$message.success("删除成功");
                    this.findBySearch();
                } else {
                    this.$message.error(res.msg);
                }
            })
        },
        //批量删除
        delBatch() {
            if (this.multipleSelection.length === 0) {
                this.$message.warning("请勾选需要删除的项")
                return
            }
            request.put("/comment/delBatch", this.multipleSelection).then(res => {
                if (res.code === '0') {
                    this.$message.success("批量删除成功！")
                    this.multipleSelection = [];
                    this.findBySearch();
                } else {
                    this.$message.error(res.msg);
                }
            })
        },
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        getRowKeys(row) {
            return row.id;
        },

    }
}
</script>