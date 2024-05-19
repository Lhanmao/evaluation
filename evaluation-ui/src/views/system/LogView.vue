<template>
    <div>
        <div>
            <div style="margin-bottom: 15px;">
                <el-input v-model="params.name" style="width: 200px;" placeholder="请输入操作内容"
                    @change="findBySearch()"></el-input>
                <el-input v-model="params.username" style="width: 200px;margin-left: 5px;" placeholder="请输入姓名"
                    @change="findBySearch()"></el-input>
                <el-button type="warning" round style="margin-left:5px" @click="findBySearch()">查询</el-button>
                <el-button type="warning" round style="margin-left:5px" @click="reset()">重置</el-button>

            </div>
            <div>
                <el-table :data="tableData" height="300" border style="width: 100%">
                    <el-table-column prop="name" label="操作内容">
                    </el-table-column>
                    <el-table-column prop="time" label="操作时间">
                    </el-table-column>
                    <el-table-column prop="username" label="操作人">
                    </el-table-column>
                    <el-table-column prop="ip" label="IP"></el-table-column>
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
                name: '',
                phone: '',
                pageNum: 1,
                pageSize: 5
            },
            tableData: [],
            total: 0,
        }
    },
    created() {
        this.findBySearch();
    },
    methods: {
        //查表
        findBySearch() {
            request.get("/log/search", {
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
                name: '',
                phone: ''
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
            request.delete("/log/delete/" + id).then(res => {
                if (res.code === '0') {
                    this.$message({
                        message: "删除成功",
                        type: 'success'
                    });
                    this.findBySearch();
                } else {
                    this.$message({
                        message: res.msg,
                        type: 'error'
                    })
                }
            })
        },

    }
}
</script>