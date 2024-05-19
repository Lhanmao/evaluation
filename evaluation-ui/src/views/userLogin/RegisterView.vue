<template>
    <div>
        <div
            style="width: 400px;height: 500px;margin: 80px auto;background-color: rgba(107, 149, 224, 0.5);border-radius: 10px;">
            <div>
                <div
                    style="width: 100%;height: 100px;font-size: 30px;line-height: 100px;color: #4a51d0;text-align: center;">
                    注册</div>
                <div style="margin-top: 25px;height: 320px;">
                    <el-form :model="user" :rules="rules" ref="ruleForm" label-width="76px">
                        <el-form-item prop="user_name">
                            <el-input v-model="user.user_name" prefix-icon="el-icon-user" style="width: 80%;"
                                placeholder="请输入用户名"></el-input>
                        </el-form-item>
                        <el-form-item prop="password">
                            <el-input v-model="user.password" prefix-icon="el-icon-lock" style="width: 80%;"
                                show-password placeholder="请输入密码"></el-input>
                        </el-form-item>
                        <el-form-item prop="age">
                            <el-input v-model="user.age" prefix-icon="el-icon-date" style="width: 80%;"
                                placeholder="请输入年龄"></el-input>
                        </el-form-item>
                        <el-form-item label-width="150px">
                            <div>
                                <el-radio v-model="user.gender" label="男">男</el-radio>
                                <el-radio v-model="user.gender" label="女">女</el-radio>
                            </div>
                        </el-form-item>
                        <el-form-item prop="phone">
                            <el-input v-model="user.phone" prefix-icon="el-icon-phone" style="width: 80%;"
                                placeholder="请输入手机号码"></el-input>
                        </el-form-item>
                        <el-form-item>
                            <el-button style="width: 80%;margin-top: 10px;" type="primary" @click="regist()">
                                注册
                            </el-button>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="text" @click="toLogin()">返回登录</el-button>
                        </el-form-item>
                    </el-form>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import request from '@/utils/request';

export default {
    name: 'RegisterView',
    data() {
        return {
            user: {
                gender: '男'
            },
            rules: {
                user_name: [{
                    required: true, message: '请输入用户名', trigger: 'blur'
                }, { min: 2, max: 5, message: '长度在 2 到 10 个字', trigger: 'blur' }],
                password: [{
                    required: true, message: '请输入密码', trigger: 'blur'
                }, { min: 6, max: 80, message: '长度不少于6位', trigger: 'blur' }],
                phone: [{ required: true, message: '请选择手机号', trigger: 'blur' },
                { min: 11, max: 11, message: '请正确输入手机号', trigger: 'blur' }]
            },
            ruleForm: {
                user_name: '',
                password: '',
                phone: '',
            }
        }
    },
    created() {

    },
    methods: {
        regist() {
            request.post("/regist", this.user).then(res => {
                if (res.code === '0') {
                    this.$message({
                        message: "注册成功",
                        type: 'success'
                    });
                    this.$router.push('/login');
                } else {
                    this.$message({
                        message: res.msg,
                        type: 'error'
                    });
                }
            })
        },
        toLogin() {
            this.$router.push('/login');
        }
    }
}
</script>