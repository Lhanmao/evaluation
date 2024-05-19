<template>
    <div>
        <div
            style="width: 400px;height: 500px;margin: 80px auto;background-color: rgba(107, 149, 224, 0.5);border-radius: 10px;">
            <div
                style="width: 100%;height: 100px;font-size: 30px;line-height: 100px;text-align: center;color: #4a51d0;">
                忘记密码</div>
            <div style="margin-top: 25px;text-align: center;height: 320px;">
                <el-form :model="user">
                    <el-form-item>
                        <el-input v-model="user.user_name" prefix-icon="el-icon-user" style="width: 80%;"
                            placeholder="请输入用户名"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-input v-model="user.phone" prefix-icon="el-icon-phone" style="width: 80%;"
                            placeholder="请输入手机号码"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-input v-model="newPwd1" prefix-icon="el-icon-lock" style="width: 80%;" show-password
                            placeholder="请输入修改密码"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-input v-model="newPwd2" prefix-icon="el-icon-lock" style="width: 80%;" show-password
                            placeholder="请再次输入密码"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button style="width: 80%;margin-top: 10px;" type="primary" @click="repwd()">
                            修改
                        </el-button>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="text" @click="toLogin()">返回登录</el-button>
                    </el-form-item>
                </el-form>
            </div>

        </div>
    </div>
</template>

<script>
import request from '@/utils/request';

export default {
    name: 'RePwd',
    data() {
        return {
            user: {},
            newPwd1: '',
            newPwd2: '',
        }
    },
    created() {

    },
    methods: {
        repwd() {
            if (this.newPwd1 != this.newPwd2) {
                this.$message.error("两次密码输入不匹配");
                return;
            }
            this.user.password = this.newPwd2;
            request.post("/rePwd", this.user).then(res => {
                if (res.code === '0') {
                    this.$message.success("修改成功");
                    this.$router.push('/login');
                } else {
                    this.$message.error(res.msg);
                }
            })
        },
        toLogin() {
            this.$router.push('/login');
        }
    }
}
</script>