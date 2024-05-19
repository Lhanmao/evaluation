<template>
    <div>
        <div
            style="width: 400px;height: 365px;margin: 150px auto;background-color: rgba(107, 149, 224, 0.5);border-radius: 10px;">
            <div
                style="width: 100%;height: 100px;font-size: 30px;line-height: 100px;text-align: center;color: #4a51d0;">
                欢迎登录</div>
            <div style="text-align: center;height: 320px;">
                <el-form :model="user">
                    <el-form-item>
                        <el-input v-model="user.user_name" prefix-icon="el-icon-user" style="width: 80%;"
                            placeholder="请输入用户名"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-input v-model="user.password" show-password prefix-icon="el-icon-lock" style="width: 80%;"
                            placeholder="请输入密码"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <div style="display: flex;justify-content: center;">
                            <!-- @keyup.enter.native="login"开启回车登录 -->
                            <el-input v-model="user.verCode" style="width: 42%;margin-right: 10px;" placeholder="请输入验证码"
                                @keyup.enter.native="login"></el-input>
                            <img :src="captchaUrl" @click="clikcImg()" width="140px" height="33px" />
                        </div>
                    </el-form-item>
                    <el-form-item>
                        <el-button style="width: 80%;margin-top: 10px;" type="primary" @click="login()">
                            登录
                        </el-button>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="text" @click="toRePwd()">忘记密码？</el-button>
                        <el-button type="text" @click="toRegist()">前往注册</el-button>
                    </el-form-item>
                </el-form>
            </div>

        </div>
    </div>
</template>

<script>
import request from '@/utils/request';

export default {
    name: 'LoginView',
    data() {
        return {
            user: {
                user_name: 'admin',
                password: '123456'
            },
            key: '',
            captchaUrl: ''
        }
    },
    mounted() {
        this.key = Math.random();
        this.captchaUrl = 'http://localhost:8080/api/captcha?key=' + this.key
    },
    methods: {
        login() {
            request.post("/login", this.user).then(res => {
                if (res.code === '0') {
                    this.$message({
                        message: "登录成功",
                        type: 'success'
                    });
                    this.user.verCode = ''
                    localStorage.setItem("user", JSON.stringify(res.data));
                    this.$router.push('/home');
                } else {
                    this.$message({
                        message: res.msg,
                        type: 'error'
                    });
                    this.user.verCode = ''
                    this.key = Math.random();
                    this.captchaUrl = 'http://localhost:8080/api/captcha?key=' + this.key
                }
            })
        },
        toRegist() {
            this.$router.push('/regist');
        },
        toRePwd() {
            this.$router.push('/rePwd');
        },
        clikcImg() {
            this.key = Math.random();
            this.captchaUrl = 'http://localhost:8080/api/captcha?key=' + this.key
        }
    }
}
</script>
<style>
.login-container {
    height: 100vh;
    overflow: hidden;
    background-image: url("@/assets/loginIma.jpg");
    background-size: 100%;
    /* display: flex; */
    /* align-items: center;
    justify-content: center; */
}
</style>