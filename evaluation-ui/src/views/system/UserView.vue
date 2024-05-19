<template>
    <div>
        <div>
            <div style="margin-bottom: 15px;">
                <el-input v-model="params.name" style="width: 200px;" placeholder="请输入姓名"
                    @change="findBySearch()"></el-input>
                <el-input v-model="params.phone" style="width: 200px;margin-left: 5px;" placeholder="请输入电话号码"
                    @change="findBySearch()"></el-input>
                <el-button type="warning" round style="margin-left:5px" @click="findBySearch()">查询</el-button>
                <el-button type="warning" round style="margin-left:5px" @click="reset()">重置</el-button>
                <el-button type="primary" round style="margin-left:10px" @click="add()">新增</el-button>
                <el-popconfirm title="确定批量删除吗？" @confirm="delBatch()">
                    <el-button slot="reference" type="danger" round style="margin-left: 5px;">批量删除</el-button>
                </el-popconfirm>
                <el-popconfirm title="确定导出数据吗？" @confirm="expData()">
                    <el-button slot="reference" type="success" round style="margin-left:10px">数据导出</el-button>
                </el-popconfirm>
                <el-upload action="http://localhost:8080/api/user/inport" :on-success="successInport"
                    style="display: inline-block;" :show-file-list="false">
                    <el-button type="success" round style="margin-left:10px">导入数据</el-button>
                </el-upload>
            </div>
            <div>
                <el-table :data="tableData" height="300" border style="width: 100%"
                    @selection-change="handleSelectionChange" ref="table" :row-key="getRowKeys">
                    <el-table-column type="selection" width="55" ref="table" :reserve-selection="true">
                    </el-table-column>
                    <el-table-column prop="user_name" label="姓名" width="90px">
                    </el-table-column>
                    <el-table-column prop="nick_name" label="昵称" width="90px">
                    </el-table-column>
                    <el-table-column prop="user_type" label="用户类型" width="90px">
                    </el-table-column>
                    <el-table-column prop="age" label="年龄" width="60px">
                    </el-table-column>
                    <el-table-column prop="gender" label="性别" width="60px">
                    </el-table-column>
                    <el-table-column prop="phone" label="电话号码">
                    </el-table-column>
                    <el-table-column prop="email" label="邮箱">
                    </el-table-column>
                    <el-table-column prop="create_date" label="创建日期"></el-table-column>
                    <el-table-column label="操作">
                        <template slot-scope="scope">
                            <el-button type="primary" round @click="edit(scope.row)">编辑</el-button>
                            <el-popconfirm title="确定删除吗？" @confirm="del(scope.row.user_id)">
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
            <el-dialog title="填写信息" :visible.sync="dialogFormVisible" destroy-on-close>
                <el-form :model="form">
                    <el-form-item label="姓名" label-width="15%">
                        <el-input v-model="form.user_name" autocomplete="off" style="width: 90%;"
                            placeholder="请输入姓名"></el-input>
                    </el-form-item>
                    <el-form-item label="昵称" label-width="15%">
                        <el-input v-model="form.nick_name" autocomplete="off" style="width: 90%;"
                            placeholder="请输入昵称"></el-input>
                    </el-form-item>
                    <el-form-item label="用户类型" label-width="15%">
                        <el-select v-model="form.user_type" placeholder="请选择">
                            <el-option key="管理员" label="管理员" value="管理员">
                            </el-option>
                            <el-option key="用户" label="用户" value="用户">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="性别" label-width="15%">
                        <el-radio v-model="form.gender" label="男">男</el-radio>
                        <el-radio v-model="form.gender" label="女">女</el-radio>
                    </el-form-item>
                    <el-form-item label="年龄" label-width="15%">
                        <el-input v-model="form.age" style="width: 90%;" placeholder="请输入年龄"></el-input>
                    </el-form-item>
                    <el-form-item label="电话" label-width="15%">
                        <el-input v-model="form.phone" autocomplete="off" style="width: 90%;"
                            placeholder="请输入电话号码"></el-input>
                    </el-form-item>
                    <el-form-item label="邮箱" label-width="15%">
                        <el-input v-model="form.email" autocomplete="off" style="width: 90%;"
                            placeholder="请输入邮箱"></el-input>
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
                phone: '',
                pageNum: 1,
                pageSize: 5
            },
            tableData: [],
            total: 0,
            dialogFormVisible: false,
            form: {},
            multipleSelection: [],
        }
    },
    mounted() {
        this.findBySearch();
    },
    methods: {
        //查表
        findBySearch() {
            request.get("/user/search", {
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
        //新增功能
        add() {
            this.form = {};
            this.dialogFormVisible = true;
        },
        //提交功能
        submit() {
            request.post("/user/add", this.form).then(res => {
                if (res.code === '0') {
                    this.$message({
                        message: "操作成功",
                        type: 'success'
                    });
                    this.dialogFormVisible = false;
                    this.findBySearch();
                } else {
                    this.$message({
                        message: res.msg,
                        type: 'error'
                    })
                }
            })
        },
        // 编辑功能
        edit(obj) {
            this.form = JSON.parse(JSON.stringify(obj));
            this.dialogFormVisible = true;
        },
        //删除功能
        del(id) {
            request.delete("/user/delete/" + id).then(res => {
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
        //批量删除
        delBatch() {
            if (this.multipleSelection.length === 0) {
                this.$message.warning("请勾选需要删除的项")
                return
            }
            request.put("/user/delBatch", this.multipleSelection).then(res => {
                if (res.code === '0') {
                    this.$message.success("批量删除成功！")
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
            return row.user_id;
        },
        //导出数据功能
        expData() {
            let user = localStorage.getItem("user");
            location.href = 'http://localhost:8080/api/user/export?token=' + JSON.parse(user).token;
        },
        //导入数据功能
        successInport(res) {
            if (res.code === '0') {
                this.$message.success("数据导入成功!")
                this.findBySearch();
            } else {
                this.$message.error(res.msg)
            }
        }
    }
}
</script>