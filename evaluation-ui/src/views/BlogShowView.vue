<template>
    <div class="container" style="background-color: #f2f3f5;">
        <TopBar></TopBar>
        <div>
            <div class="article-suspended-panel">
                <div class="panel-btn btn_3" style="margin-bottom: 1.2rem;cursor: pointer;" @click="likeClick">
                    <div style="height: 100%;display: flex;">
                        <span style="color: #666;font-size: 22px;height: 100%;">
                            <i class="el-icon-like" style="margin: 13px;margin-right: 3px;" v-if="(isLike === '0')"></i>
                            <i class="el-icon-like" style="margin: 13px;margin-right: 3px;color: orange;" v-else></i>
                        </span>
                        <el-badge :value="likeNum" type="info"></el-badge>
                    </div>
                </div>
                <div class="panel-btn btn_3" style="margin-bottom: 1rem;cursor: pointer;" @click="scrollToPosition">
                    <div style="height: 100%;display: flex;">
                        <span style="color: #666;font-size: 22px;height: 100%;">
                            <i class="el-icon-chat-dot-square" style="margin: 13px;margin-right: 3px;"></i>
                        </span>
                        <el-badge :value="allNum" type="info"></el-badge>
                    </div>
                </div>
                <div class="panel-btn btn_3" style="margin-bottom: 1rem;cursor: pointer;" @click="collectClick">
                    <div style="height: 100%;display: flex;">
                        <span style="color: #666;font-size: 22px;height: 100%;">
                            <i class="el-icon-star-on" style="margin: 13px;margin-right: 3px;"
                                v-if="(isCollect === '0')"></i>
                            <i class="el-icon-star-on" style="margin: 13px;margin-right: 3px;color: orange;" v-else></i>
                        </span>
                        <el-badge :value="collectNum" type="info"></el-badge>
                    </div>
                </div>
                <div></div>
            </div>
            <div style="display: flex;gap: 25px;padding-top: 24px;padding-left: 10%;">
                <div style="display: flex;flex-direction: column;gap: 20px;">
                    <!-- 文章模块 -->
                    <div class="card" style="width: 830px;">
                        <div style="padding-top: 18px;padding-right: 2.5rem;padding-left: 2.5rem;">
                            <div>
                                <h1>{{ this.curBlog.title }}</h1>
                            </div>
                            <div style="display: flex;">
                                <div style="margin-bottom: 20px;margin-right: 16px;">
                                    <a>{{ this.curBlog.userName }}</a>
                                </div>
                                <div style="display: flex;gap: 16px;">
                                    <div style="color:#666;">{{ this.curBlog.date }}</div>
                                    <span style="color: #666;margin-right: 20px;">
                                        <i class="el-icon-eye">
                                        </i>{{ this.curBlog.read_count }}
                                    </span>
                                    <span style="color: #666;margin-right: 20px;">
                                        品牌：
                                        <el-tag style="font-size: 13px;">
                                            {{ this.curBlog.categoryName }}
                                        </el-tag>
                                    </span>
                                </div>
                            </div>
                            <div v-html="this.curBlog.content">
                            </div>
                        </div>
                    </div>
                    <!-- 评论模块 -->
                    <div class="card" style="width: 830px;" id="commentId">
                        <Comment :blog_id="id" @allCommentNum="allCommentNum"></Comment>
                    </div>
                </div>
                <div class="card_right" style="height: 150px;">
                    <div style="padding: 20px;">
                        <a href="/home" style="display: flex;margin-left: 15px;">
                            <div>
                                <el-image style="width: 50px; height: 50px;border-radius: 50%;margin-right: 12px;"
                                    :src="blogAvaUrl">
                                </el-image>
                            </div>
                            <span style="font-size: 16px;margin-top: auto;margin-bottom: auto;">
                                {{ this.curBlog.userName }}</span>
                        </a>
                        <div style="padding: 12%;display: flex;">
                            <el-button type="primary" size="medium">关注</el-button>
                            <el-button type="primary" plain size="medium" @click="toChat()">私信</el-button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import request from '@/utils/request';
import TopBar from '../components/TopBarView.vue'
import Comment from '../components/Comment.vue'

export default {
    data() {
        return {
            params: {},
            likeNum: '',
            collectNum: '',
            user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},//当前登录的用户
            isSticky: false,
            isUser: true,
            avaUrl: '',//当前用户头像地址
            blogAvaUrl: '',//文章作者头像地址
            id: '',//文章ID
            fPath: '',//地址栏地址
            curBlog: {},//当前文章
            blogUser: {},//文章作者
            isLike: '0',
            isCollect: '0',
            addLikeData: {
                user_id: '',
                blog_id: '',
                peolike: '0',
                collect: '0'
            },
            allNum: '',
            chatParams: {
                user_id: '',
                target_user_id: ''
            }
        }
    },
    components: {
        TopBar,
        Comment
    },
    beforeCreate() {
        this.$nextTick(() => {
            document.body.setAttribute('style', 'background:#f2f3f5')
        })
    },
    beforeDestroy() {
        document.body.removeAttribute('style')
    },
    created() {
        this.isUser = localStorage.getItem("user") ? false : true
        this.avaUrl = 'http://localhost:8080/api/files/' + this.user.avatar
        // this.fPath = this.$route.fullPath
        // this.id = this.fPath.substring(this.fPath.indexOf('blogId=') + 7)
        this.id = this.$route.query.blogId
        this.findBlog();
        this.findLikeNum();
    },
    mounted() {
        window.addEventListener('scroll', this.handleScroll)
    },
    destroyed() {
        window.removeEventListener('scroll', this.handleScroll)
    },
    methods: {
        handleScroll() {
            //顶栏
            const scrollTop = window.pageYOffset || document.documentElement.scrollTop
            this.isSticky = scrollTop > 0 // 当页面滚动超过248px时启用固定
        },
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
        // 查询文章
        findBlog() {
            this.addReadCount();
            request.get("/blog/findById/" + this.id).then(res => {
                if (res.code === '0') {
                    this.curBlog = res.data
                } else {
                    this.$message.error(res.msg)
                }
                this.findBlogUser();
            })

        },
        // 查询文章作者
        findBlogUser() {
            request.get("/user/findById/" + this.curBlog.user_id).then(res => {
                if (res.code === '0') {
                    this.blogUser = res.data
                } else {
                    this.$message.error(res.msg)
                }
                this.blogAvaUrl = 'http://localhost:8080/api/files/' + this.blogUser.avatar
                this.addLikeData.user_id = this.user.user_id
                this.addLikeData.blog_id = this.curBlog.id
                // setTimeout(() => {
                this.findLike();
                // }, 0)
            })
        },
        // 阅读量增加
        addReadCount() {
            request.post("/blog/addRead/" + this.id).then(res => {
                if (res.code === '0') {
                } else {
                    this.$message.error(res.msg)
                }
            })
        },
        findLike() {
            request.post("/peopleLike/findLike", this.addLikeData).then(res => {
                if (res.code === '0') {
                    if (res.data != null) {
                        this.isLike = res.data.peolike
                        this.isCollect = res.data.collect
                    }
                } else {
                }
            })
        },
        findLikeNum() {
            this.params.blog_id = this.id
            request.get("/peopleLike/findLikeNum", {
                params: this.params
            }).then(res => {
                if (res.code === '0') {
                    if (res.data != null) {
                        this.likeNum = res.data.likeNum
                        this.collectNum = res.data.collectNum
                    }
                } else {
                }
            })
        },
        likeClick() {
            if (this.isLike == '0') {
                this.addLikeData.peolike = '1';
                this.addLikeData.collect = this.isCollect;
                request.post("/peopleLike/add", this.addLikeData).then(res => {
                    if (res.code === '0') {
                        this.$message.success("点赞成功")
                        this.isLike = '1';
                        this.findLikeNum()
                    }
                    else {
                        this.$message.error(res.msg)
                    }
                })

            }
            else {
                this.addLikeData.peolike = '0';
                this.addLikeData.collect = this.isCollect;
                request.post("/peopleLike/add", this.addLikeData).then(res => {
                    if (res.code === '0') {
                        this.isLike = '0';
                        this.$message.success("取消点赞")
                        this.findLikeNum()
                    }
                    else {
                        this.$message.error(res.msg)
                    }
                })
            }

        },
        collectClick() {
            if (this.isCollect === '0') {
                this.addLikeData.peolike = '1';
                this.addLikeData.collect = '1';
                request.post("/peopleLike/add", this.addLikeData).then(res => {
                    if (res.code === '0') {
                        this.$message.success("收藏成功")
                        this.isLike = '1';
                        this.isCollect = '1';
                        this.findLikeNum()
                    }
                    else {
                        this.$message.error(res.msg)
                    }
                })
            }
            else {
                this.addLikeData.peolike = '1'
                this.addLikeData.collect = '0';
                request.post("/peopleLike/add", this.addLikeData).then(res => {
                    if (res.code === '0') {
                        this.$message.success("取消收藏")
                        this.isCollect = '0';
                        this.findLikeNum()
                    }
                    else {
                        this.$message.error(res.msg)
                    }
                })
            }
            this.findLikeNum()
        },
        scrollToPosition() {
            var target = document.getElementById("commentId");
            if (target) {
                // 将视口滚动到目标组件的位置
                window.scrollTo({ top: target.offsetTop, behavior: 'smooth' });
            } else {
                console.log('未找到目标组件');
            }
        },
        allCommentNum(num) {
            this.allNum = num
        },
        toChat() {
            this.chatParams.user_id = this.user.user_id
            this.chatParams.target_user_id = this.curBlog.user_id
            console.log(this.chatParams)
            request.post("/userSession/add", this.chatParams).then(res => {
                if (res.code === '0') {
                    this.$router.push('/chat?chatId=' + this.blogUser.user_id)
                }
            })

        }
    },
}
</script>
<style scoped>
.el-menu {
    border-right: none !important;
    color: #1e80ff;
}

.el-menu-item:hover {
    color: #1e80ff !important;
    background-color: #f4f6f9 !important;
}

.btn_3:hover {
    color: #1e80ff !important;
    background-color: #f4f6f9 !important;
}

.btn-item-info {

    margin-right: 4px;
}

.is-sticky {
    position: fixed;
    /* 设置固定定位 */
    top: 0;
    /* 设置固定在顶部 */
    width: 100%;
    z-index: 2;
}

.container {
    height: 100%;
    /* 设置容器高度，使得可以滚动 */
}

.sticky-header {
    position: relative;
    /* 设置顶部相对定位 */
}

.article-suspended-panel {
    position: fixed;
    margin-top: 8%;
    top: 10%;
    margin-left: 2rem;
    top: 10px;
    z-index: 2;
}

.panel-btn {
    box-shadow: 0 3px 6px 0 rgba(0, 0, 0, 0.2);
    transition: 0.2s;
    width: 48px;
    height: 48px;
    border-radius: 50%;
    background-color: #fff;
    /* margin: auto; */
    /* text-align: left; */
}

.p {
    margin-top: 22px;
    margin-bottom: 22px;
}

a {
    text-decoration: none;
    color: inherit;
}
</style>