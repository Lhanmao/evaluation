<template>
    <div class="app-container">
        <el-row :gutter="20">
            <el-col :span="6" :xs="24">
                <el-card class="box-card">
                    <div slot="header" class="clearfix">
                        <span>个人信息</span>
                    </div>
                    <div>
                        <div class="text-center">
                            <el-upload action="http://localhost:8080/api/files/upload" :show-file-list="false"
                                :on-success="handleAvatarSuccess" class="avatar-uploader">
                                <img v-if="imageUrl" :src="imageUrl" class="avatar">
                                <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                            </el-upload>
                        </div>
                        <ul style="font-size: small;padding-left: 0;">
                            <el-divider></el-divider>
                            <li class="nonePot">
                                <!-- <div> -->
                                <i class="el-icon-user-solid">用户名称</i>
                                <div class="pull-right">{{ user.user_name }}
                                </div>
                                <!-- </div> -->
                            </li>
                            <el-divider></el-divider>
                            <li class="nonePot">
                                <i class="el-icon-mobile-phone">手机号码</i>
                                <div class="pull-right">{{ user.phone }}</div>
                            </li>
                            <el-divider></el-divider>
                            <li class="nonePot">
                                <i class="el-icon-message">邮箱</i>
                                <div style="width: 150px;float: right;text-align: right;">{{ user.email }}</div>
                            </li>
                            <el-divider></el-divider>
                            <li class="nonePot">
                                <i class="el-icon-s-custom">用户类型</i>
                                <div class="pull-right">{{ user.user_type }}</div>
                            </li>
                            <el-divider></el-divider>
                            <li class="nonePot">
                                <i class="el-icon-date">创建日期</i>
                                <div class="pull-right">{{ user.create_date }}</div>
                            </li>
                            <el-divider></el-divider>
                        </ul>
                    </div>
                </el-card>
            </el-col>
            <el-col :span="18" :xs="24">
                <el-card>
                    <div slot="header" class="clearfix">
                        <span>基本资料</span>
                    </div>
                    <el-tabs v-model="activeTab">
                        <el-tab-pane label="基本资料" name="userinfo">
                            <UserMsg :cuser="user" @refresh="getUser"></UserMsg>
                        </el-tab-pane>
                        <el-tab-pane label="修改密码" name="resetPwd">
                            <ResetPwd />
                        </el-tab-pane>
                    </el-tabs>
                </el-card>
            </el-col>
        </el-row>
    </div>
</template>

<script>
import request from '@/utils/request';
import UserMsg from "./UserMsg.vue";
import ResetPwd from "./ResetPwd.vue";

export default {
    name: "Profile",
    data() {
        return {
            user: {},
            roleGroup: {},
            postGroup: {},
            activeTab: "userinfo",
            imageUrl: '',
        };
    },
    components: {
        UserMsg,
        ResetPwd
    },
    created() {
        this.getUser();

        console.log("create函数")
    },
    methods: {
        getUser() {
            this.user = JSON.parse(localStorage.getItem("user"));
            console.log(this.user)
            if (this.user.avatar) {
                this.imageUrl = 'http://localhost:8080/api/files/' + this.user.avatar;
            }
        },
        handleAvatarSuccess(res) {
            this.user.avatar = res.data;
            request.post("/user/add", this.user).then(res => {
                if (res.code === '0') {
                    this.$message.success("操作成功");
                    this.imageUrl = 'http://localhost:8080/api/files/' + this.user.avatar;
                    localStorage.setItem("user", JSON.stringify(this.user));
                } else {
                    this.$message({
                        message: res.msg,
                        type: 'error'
                    })
                }
            })
        }
    }
};
</script>

<style>
.nonePot {
    list-style-type: none;
}

.pull-right {
    width: 110px;
    float: right;
    text-align: right;
}

.avatar {
    width: 170px;
    height: 170px;
    display: block;
    border-radius: 50%;
}

.avatar-uploader-icon {
    font-size: 50px;
    color: #8c939d;
    width: 170px;
    height: 115px;
    line-height: 170px;
    text-align: center;
    margin-top: 38%;
}

.avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 50%;
    cursor: pointer;
    position: relative;
    overflow: hidden;
}

.avatar-uploader .el-upload:hover {
    border-color: #409EFF;
}
</style>