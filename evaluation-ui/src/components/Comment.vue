<template>
    <div style="padding-top: 18px;padding-right: 2.3rem;padding-left: 2.3rem;padding-bottom: 20px;">
        <div>
            <h1 style="font-size: 19px;">评论 {{ this.allCommentNum }}</h1>
        </div>
        <div style="display: flex;padding-top: 20px;height: 100px;">
            <div style="margin-bottom: 20px;margin-right: 16px;">
                <el-avatar :src="avaPath + currUser.avatar"></el-avatar>
            </div>
            <div style="width: 700px;height: 64px;">
                <el-input type="textarea" :rows="3" placeholder="请输入内容" v-model="textarea"></el-input>
            </div>
        </div>
        <div style="margin-left: 90%;padding-bottom: 10px;">
            <el-button type="primary" @click="sendComment(0)">发布</el-button>
        </div>
        <div>
            <div style="display: flex;">
                <div>最新</div>
                <div style="height: 13px;">
                    <el-divider direction="vertical"></el-divider>
                </div>
                <div>最热</div>
            </div>
            <div style="display:flex;padding-top: 16px;padding-bottom: 14px;" v-for="item in commentList"
                :key="item.id">
                <div style="margin-right: 16px;"><el-avatar :src="avaPath + item.avatar"></el-avatar></div>
                <div style="width: 100%;">
                    <div style="padding-top: 2px;padding-bottom: 2px;">
                        <span style="color:#666;">{{ item.user_name }}</span>
                    </div>
                    <div style="margin-top: 4px;">
                        <span style="font-weight: 500;line-height: 1.7;">{{ item.content }}</span>
                    </div>
                    <div style="display:flex;margin-top: 8px;margin-bottom: 6px;color:#666;font-size: 14px;">
                        <div style="margin-right: 10px;">{{ item.create_time }}</div>
                        <!-- <div style="padding-left: 10px;padding-right: 10px;">
                            <span style="color: #666;">
                                <i class="el-icon-like"></i>100
                            </span>
                        </div> -->
                        <div style="padding-left: 10px;padding-right: 10px;">
                            <span style="color: #666;cursor: pointer;" @click="recoverComment(item.id, item.pid)">
                                <i class="el-icon-chat-dot-square"></i>{{ commentNum[item.id] }}
                            </span>
                        </div>
                    </div>
                    <div style="padding-top: 6px;padding-bottom: 6px;">
                        <div>
                            <ChildComment :list="item.list" :recover="0"></ChildComment>
                            <div v-for="little in item.list" :key="little.id">
                                <ChildComment :list="little.list" :recover="1"></ChildComment>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <el-dialog title="回复" :visible.sync="dialogFormVisible" destroy-on-close>
            <el-form :model="form">
                <el-form-item label="评论内容" label-width="120px">
                    <el-input type="textarea" v-model="form.content" autocomplete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="sendComment(1)">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>
<script>
import request from '@/utils/request';
import ChildComment from './ChildComment.vue';

export default {
    props: {
        blog_id: '',
    },
    data() {
        return {
            commentData: {
                pid: 0,
                target_id: 0
            },
            textarea: '',
            currUser: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},//当前登录的用户
            commentList: [],
            form: {},
            dialogFormVisible: false,
            commentNum: [],
            allCommentNum: '',
            avaPath: 'http://localhost:8080/api/files/'
        }
    },
    components: {
        ChildComment
    },
    created() {
        this.findAllComment();
        this.findCommentNum();
        this.findNum();
    },
    methods: {
        sendComment(pid) {
            console.log(pid);
            if (pid === 0) {
                this.commentData.content = this.textarea;
            }
            else {
                this.commentData.content = this.form.content
            }
            this.commentData.blog_id = this.blog_id;
            this.commentData.user_id = this.currUser.user_id;
            request.post('/comment/add', this.commentData).then(res => {
                if (res.code === '0') {
                    this.$message.success("发布成功");
                    this.textarea = ''
                    this.findAllComment();
                    this.findCommentNum();
                    this.findNum();
                }
                else {
                    this.$message.error(res.msg)
                }
            })
            this.commentData.pid = 0
            this.commentData.target_id = 0
            this.dialogFormVisible = false

        },
        findAllComment() {
            request.get("/comment/findAllComment/" + this.blog_id).then(res => {
                if (res.code === '0') {
                    this.commentList = res.data
                    console.log(this.commentList)
                } else {
                    this.$message.error(res.msg)
                }
            })

        },
        recoverComment(id, isFather) {
            this.form = {}
            if (isFather === 0) {
                this.commentData.pid = id
                this.commentData.target_id = isFather
            }
            else {
                this.commentData.pid = isFather
                this.commentData.target_id = id
            }
            this.dialogFormVisible = true
        },
        findCommentNum() {
            request.get('/comment/findCommentNum/' + this.blog_id).then(res => {
                if (res.code === '0') {
                    this.commentNum = res.data
                }
            })
        },
        findNum() {//寻找文章全部评论
            request.get('/comment/findNum/' + this.blog_id).then(res => {
                if (res.code === '0') {
                    this.allCommentNum = res.data
                    this.$emit('allCommentNum', this.allCommentNum)
                }
            })
        },
    }
}
</script>
<style></style>