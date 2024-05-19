<template>
    <div>
        <div style="display: flex;" v-for="item in list" :key="item.id">
            <div style="margin-right: 12px;margin-top: 5px;">
                <el-avatar style="height: 30px;width: 30px;" :src="avaPath + item.avatar"></el-avatar>
            </div>
            <div style="margin-top: auto;margin-bottom: auto;width: 100%;">
                <div style="width: 100%;margin-top: 3px;">
                    <div style="display: flex;margin-bottom: 2px;">
                        <div style="color:#666;">{{ item.user_name }}</div>

                        <span v-if="recover === 0"> ：</span>
                        <span v-else style="margin-left: 5px;">
                            回复：<span style="color:#666;">{{ item.recUserName }}</span>
                        </span>
                    </div>
                    <span style="text-overflow: ellipsis;line-height: 1.5;">{{ item.content }}</span>
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
                            <i class="el-icon-chat-dot-square"></i>
                        </span>
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

export default {
    props: {
        list: [],
        recover: '',
    },
    data() {
        return {
            recUser: '',
            dialogFormVisible: false,
            form: {},
            avaPath: 'http://localhost:8080/api/files/'
        }
    },
    created() {

    },
    methods: {
        findRecUser(target_id) {
            request.get('/comment/findRecUser/' + target_id).then(res => {
                if (res.code === '0') {
                    this.recUser = res.data
                } else {
                    this.$message.error(res.msg)
                }
            })
            return this.recUser.user_name
        },
        sendComment(pid) {
            this.$parent.sendComment(pid)

        },
        recoverComment(id, isFather) {
            this.$parent.recoverComment(id, isFather)
        }
    }

}
</script>