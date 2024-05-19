<template>
    <el-form ref="form" :model="user" :rules="rules" label-width="80px">
        <el-form-item label="旧密码" prop="oldPassword">
            <el-input v-model="user.oldPassword" placeholder="请输入旧密码" type="password" show-password />
        </el-form-item>
        <el-form-item label="新密码" prop="newPassword">
            <el-input v-model="user.newPassword" placeholder="请输入新密码" type="password" show-password />
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
            <el-input v-model="user.password" placeholder="请确认新密码" type="password" show-password />
        </el-form-item>
        <el-form-item>
            <el-button type="primary" size="mini" @click="submit">保存</el-button>
            <el-button type="danger" size="mini" @click="close">关闭</el-button>
        </el-form-item>
    </el-form>
</template>

<script>
import request from '@/utils/request';

export default {
    data() {
        return {
            user: {
                oldPassword: '',
                newPassword: '',
                password: ''
            },
            curUser: {},
            // 表单校验
            rules: {
                oldPassword: [
                    { required: true, message: "旧密码不能为空", trigger: "blur" }
                ],
                newPassword: [
                    { required: true, message: "新密码不能为空", trigger: "blur" },
                    { min: 6, max: 20, message: "长度在 6 到 20 个字符", trigger: "blur" }
                ],
                password: [
                    { required: true, message: "确认密码不能为空", trigger: "blur" },
                    { required: true, trigger: "blur" }
                ]
            }
        };
    },
    methods: {
        submit() {
            this.curUser = JSON.parse(localStorage.getItem("user"))
            if (this.user.oldPassword != this.curUser.password) {
                this.$message.error("旧密码错误!请重新输入")
                return
            }
            else if (this.user.newPassword != this.user.password) {
                this.$message.error("两次新密码输入不相同！请重新输入")
                return
            }
            else {
                this.curUser.password = this.user.password
                request.post("/user/add", this.curUser).then(res => {
                    if (res.code === '0') {
                        this.$message.success("修改成功！")
                        localStorage.setItem("user", JSON.stringify(this.curUser));
                    }
                    else {
                        this.$message.error("修改失败！")
                    }
                })
            }
        },
        close() {

        }
    }
};
</script>