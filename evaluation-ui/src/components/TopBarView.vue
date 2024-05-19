<template>
    <div>
        <div :class="{ 'is-sticky': isSticky }" style="display:inline-block;width: 100%;">
            <el-container style="background-color: #ffffff;">
                <aside>
                    <div style="padding-left: 10px;">
                        <a href="/home">
                            <img src="@/assets/logo.png" alt="" style="width:40px;position: relative;top: 10px;">
                            <span style="margin-left: 12px;color:black;font-weight: 550;">鞋评测</span>
                        </a>
                    </div>
                </aside>
                <aside style="margin-left: auto;margin-right: auto;">
                    <el-menu :default-active="activeIndex" router mode="horizontal" background-color="#ffffff"
                        text-color="#fff" active-text-color="#1e80ff" style="border-bottom: none !important;">
                        <el-menu-item index="/home" active><i v-bind:title="iconHome" class="el-icon-s-home"
                                style="font-size: 28px;margin-right: 10px;margin-left: 10px;"></i></el-menu-item><!--首页-->
                        <el-menu-item index="/dataVision"><i v-bind:title="iconHot" class="el-icon-s-data"
                                style="font-size: 28px;margin-right: 10px;margin-left: 10px;"></i></el-menu-item><!--热门-->
                        <el-menu-item index="/chat"><i v-bind:title="iconMess" class="el-icon-message"
                                style="font-size: 28px;margin-right: 10px;margin-left: 10px;"></i></el-menu-item><!--消息-->
                        <el-menu-item index="/center"><i v-bind:title="iconUser" class="el-icon-user-solid"
                                style="font-size: 28px;margin-right: 10px;margin-left: 10px;"></i></el-menu-item><!--用户-->
                    </el-menu>
                </aside>
                <aside style="margin-top: auto;margin-bottom: auto;margin-right: 20px;">
                    <div style="float: left;display: flex;padding-top: 8px;margin-right: 10px;">
                        <el-input placeholder="请输入标题内容" v-model="titleSearch" class="input-with-select"
                            prefix-icon="el-icon-search" size="medium" @keyup.enter.native="toSearch()">
                            <el-button slot="append" @click="toSearch()">搜索</el-button>
                        </el-input>
                    </div>
                    <div style="float: left;display: flex;padding-top: 8px;margin-right: 10px;">
                        <el-button type="primary" round @click="pubEvaluation">
                            发表测评
                        </el-button>
                    </div>
                    <div v-if="isUser" style="float: right;margin-top: 8.5px;margin-right: 10px;">
                        <el-button type="primary" round @click="redirectToLogin()">登录</el-button>
                        <el-button type="text" @click="redirectRegist()" style="font-weight: 600;">注册</el-button>
                    </div>
                    <div v-else style="float: right;">
                        <el-dropdown>
                            <el-image style="width: 46px; height: 46px;border-radius: 25%;" :src="avaUrl">
                            </el-image>
                            <span style="color:black;">
                                <i class="el-icon-arrow-down el-icon--right"></i>
                            </span>
                            <el-dropdown-menu slot="dropdown">
                                <el-dropdown-item @click.native="toInfo()">个人信息</el-dropdown-item>
                                <el-dropdown-item @click.native="loginOut()">退出登录</el-dropdown-item>
                            </el-dropdown-menu>
                        </el-dropdown>
                    </div>
                </aside>
            </el-container>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        activeIndex: ''
    },
    data() {
        return {
            titleSearch: '',
            user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},//当前登录的用户
            isSticky: false,
            iconHome: '首页',
            iconHot: '热门',
            iconMess: '消息',
            iconUser: '个人中心',
            isUser: true,
            avaUrl: '',//当前用户头像地址
        }
    },
    created() {
        this.isUser = localStorage.getItem("user") ? false : true
        this.avaUrl = 'http://localhost:8080/api/files/' + this.user.avatar
    },
    methods: {
        loginOut() {  //退出登录功能
            this.$confirm('是否确定退出登录？', '', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.$message({
                    type: 'success',
                    message: '退出成功!'
                });
                localStorage.removeItem("user");
                this.$router.go(0)
            }).catch(() => {
            });
        },
        toInfo() {
            if (this.$route.path === "/userInfo") {
                this.$router.go(0);
            }
            else {
                this.$router.push("/userInfo")
            }
        },
        redirectToLogin() {
            // 登录跳转
            this.$router.push('/login');
        },
        redirectRegist() {
            //注册跳转
            this.$router.push('/regist')
        },
        pubEvaluation() {
            this.$router.push('/public')
        },
        toSearch() {
            this.$router.push('/search?title=' + this.titleSearch)
            // this.$router.go(0)
        }
    }
}
</script>
<style>
.el-menu {
    border-right: none !important;
    color: #1e80ff;
}

.el-menu-item:hover {
    color: #1e80ff !important;
    background-color: #f4f6f9 !important;
}

.is-sticky {
    position: fixed;
    /* 设置固定定位 */
    top: 0;
    /* 设置固定在顶部 */
    width: 100%;
    z-index: 2;
}

.sticky-header {
    position: relative;
    /* 设置顶部相对定位 */
}
</style>