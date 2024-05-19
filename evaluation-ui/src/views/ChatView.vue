<template>
    <div>
        <div>
            <TopBar :activeIndex="'/chat'"></TopBar>
        </div>
        <div style="padding: 16px;height: 630px;">
            <div class="card" style="width: 100%;height: 100%;">
                <div style="display: flex;width: 100%;height: 100%;">
                    <div style="border-right: 1px solid #ddd;height: 100%;">
                        <div style="display: flex;flex-direction: column;">
                            <el-input v-model="params.name" style="padding: 18px;width: 310px;" @input="findByCurList">
                                <el-button slot="append" icon="el-icon-search" @click="findByCurList()"></el-button>
                            </el-input>
                            <div class="botimg" style="padding: 18px;display: flex;cursor: pointer;width: 310px;"
                                v-for="item in chatList" :key="item.id" :class="{ 'checkChat': item.id === curChatId }"
                                @click="clickChat(item.id, item.target_user_name, item.target_user_id)">
                                <div style="display: flex;width: 100%;"
                                    v-if="curUser.user_name != item.target_user_name">
                                    <div class="demo-basic--circle">
                                        <el-avatar style="margin-top: 2px;"
                                            :src="avaPath + item.target_user_avatar"></el-avatar>
                                    </div>
                                    <div class="userItem">
                                        <div style="width: 100%;">{{ item.target_user_name }}</div>
                                        <div style="color: #666;font-size: 13px;width: 78%;" class="line1">
                                            {{ item.content }}</div>
                                    </div>
                                </div>
                                <div style="display: flex;width: 100%;" v-else>
                                    <div class="demo-basic--circle">
                                        <el-avatar style="margin-top: 2px;"
                                            :src="avaPath + item.user_avatar"></el-avatar>
                                    </div>
                                    <div class="userItem">
                                        <div style="width: 100%;">{{ item.user_name }}</div>
                                        <div style="color: #666;font-size: 13px;width: 78%;" class="line1">
                                            {{ item.content }}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="width: 100%;height: 100%;">
                        <div class="rightChat" style="width: 100%;">
                            <div class="chatHeader">
                                <div style="font-size: 19px;">{{ targetUser }}</div>
                                <el-dropdown trigger="click" style="cursor: pointer;" @command="handleCommand"
                                    :disabled="isClean">
                                    <span class="el-dropdown-link">
                                        <i class="el-icon-more"></i>
                                    </span>
                                    <el-dropdown-menu slot="dropdown">
                                        <el-dropdown-item command="1">举报</el-dropdown-item>
                                        <el-dropdown-item command="2">关闭聊天</el-dropdown-item>
                                    </el-dropdown-menu>
                                </el-dropdown>
                            </div>
                            <div style="height: 69%;border-bottom: 1px solid #ddd;width: 100%;">
                                <div style="padding-left: 20px;padding-right: 20px;">
                                    <div style="position:absolute; height:400px; overflow-y:auto;width: 900px;">
                                        <div style="width: 100%;" v-for="item in chatContentList"
                                            :key="item.content_id">
                                            <div class="chatTime" v-if="item.scrop > 5 || item.scrop == 0">
                                                {{ item.create_date.substr(0, 16) }}
                                            </div>
                                            <div style="width: 100%;" v-if="item.user_name === curUser.user_name">
                                                <div class="sendMsg">
                                                    <div class="msg-container">
                                                        <span>{{ item.content }}</span>
                                                    </div>
                                                    <div
                                                        style="padding-left: 10px;padding-right: 10px;padding-top: 5px;">
                                                        <el-avatar style="width: 36px;height: 36px;"
                                                            :src="avaPath + item.user_avatar"></el-avatar>
                                                    </div>
                                                </div>
                                            </div>
                                            <div style="width: 100%;" v-else>
                                                <div class="receiveMsg">
                                                    <div
                                                        style="padding-left: 10px;padding-right: 10px;padding-top: 5px;">
                                                        <el-avatar style="width: 36px;height: 36px;"
                                                            :src="avaPath + item.user_avatar"></el-avatar>
                                                    </div>
                                                    <div class="msg-container">
                                                        <span>{{ item.content }}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div style="height: 22%;">
                                <div style="display: flex;flex-direction: column;height: 100%;">
                                    <div style="height: 75%;">
                                        <textarea v-model="sendContent.content" class="msg-textarea"
                                            @keyup.enter="toSend" :disabled="isClean"></textarea>
                                    </div>
                                    <div class="sendButton">
                                        <span style="font-size:14px;color: #ddd;padding-right: 12px">按下Enter发送</span>
                                        <el-button round @click="toSend()" :disabled="isClean">发送</el-button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import request from '@/utils/request';
import TopBar from "../components/TopBarView.vue";

export default {
    data() {
        return {
            params: {
                session_id: '',
            },
            avaPath: 'http://localhost:8080/api/files/',
            curUser: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
            chatList: [],
            curChatId: '',
            chatContentList: [],
            targetUser: '',
            targetUserId: '',
            sendContent: {
                session_id: '',
                content: '',
                user_id: '',
                target_user_id: ''
            },
            dateScrop: '',
            isClean: false,

        }
    },
    components: {
        TopBar
    },
    created() {
        this.curChatId = this.$route.query.chatId ?? ''
        // console.log(this.curChatId)
        this.findByCurList()
    },
    methods: {
        findByCurList() {
            this.params.id = this.curUser.user_id
            request.get("/userSession/findByCurList", { params: this.params }).then(
                res => {
                    if (res.code === '0') {
                        this.chatList = res.data
                        if (res.data.length != 0) {
                            // if (this.curChatId == '') {
                            this.curChatId = this.chatList[0].id
                            // }
                            // console.log(res.data)
                            this.params.session_id = this.curChatId
                            this.targetUser = this.chatList[0].target_user_name
                            this.targetUserId = this.chatList[0].target_user_id
                        }
                        this.findByCurId()
                    }
                })
        },
        findByCurId() {
            request.get("/userSession/findByCurId", {
                params: this.params
            }).then(res => {
                if (res.code === '0') {
                    this.chatContentList = res.data
                    if (res.data.length != 0) {
                        this.dateScrop = this.chatContentList[0].create_date
                    }
                    for (let i = 0; i < this.chatContentList.length; i++) {
                        let temp = this.compareDate(this.dateScrop, this.chatContentList[i].create_date)
                        this.$set(this.chatContentList[i], 'scrop', temp)
                    }
                }
            })
        },
        clickChat(id, name, target_id) {
            this.curChatId = id
            this.params.session_id = id
            this.targetUser = name
            this.targetUserId = target_id
            this.findByCurId()
        },
        toSend() {
            this.sendContent.session_id = this.curChatId
            this.sendContent.user_id = this.curUser.user_id
            this.sendContent.target_user_id = this.targetUserId
            request.post("/sessioncontent/add", this.sendContent).then(res => {
                if (res.code === '0') {
                    this.sendContent.content = ''
                    this.findByCurId()
                } else {
                    this.$message.info(res.msg)
                }
            })
            this.findByCurList()
        },
        compareDate(d1, d2) {
            let date1 = new Date(Date.parse(d1.substr(0, 16)))
            let date2 = new Date(Date.parse(d2.substr(0, 16)))
            this.dateScrop = d2
            let scrop = (date2 - date1) / 60000
            return scrop
        },
        cleanChat() {
            this.curChatId = ''
            this.targetUser = ''
            this.chatContentList = []
            this.isClean = true
        },
        handleCommand(command) {
            if (command == 2) {
                console.log(command)
                this.cleanChat()
            }
        }

    }
}
</script>
<style scoped>
::-webkit-scrollbar {
    width: 1px;
    /* height: 1px; */
}

::-webkit-scrollbar-thumb {
    border-radius: 10px;
    box-shadow: inset 0 0 6px #ddd;
    background-color: #ddd;
}

.rightChat {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100%;
}

.checkChat {
    text-decoration: none !important;
    display: inline-block;
    /*跟随父元素的高度*/
    /* height: inherit; */
    /* color: #1e80ff !important; */
    background-color: #f4f6f9 !important;
}

.chatHeader {
    display: flex;
    padding-left: 24px;
    padding-right: 24px;
    width: 100%;
    height: 9%;
    border-bottom: 1px solid #ddd;
    align-items: center;
    justify-content: space-between
}

.userItem {
    width: 100%;
    margin-left: 12px;
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.sendButton {
    align-items: center;
    display: flex;
    height: 25%;
    justify-content: flex-end;
    margin-right: 12px;
    margin-top: 5px;
    margin-bottom: 5px;
}

.sendMsg {
    /* align-items: center; */
    display: flex;
    height: 100%;
    justify-content: flex-end;
    margin-right: 12px;
    padding-top: 8px;
    padding-bottom: 8px;
}

.receiveMsg {
    /* align-items: center; */
    display: flex;
    height: 100%;
    justify-content: flex-start;
    margin-right: 12px;
    padding-top: 10px;
    padding-bottom: 10px;
}

.msg-textarea {
    font-size: 15px;
    flex: 1;
    width: 100%;
    height: 100%;
    resize: none;
    border: none;
    outline: none;
    padding: 10px;
}

.chatTime {
    height: 26px;
    margin-top: 8px;
    margin-bottom: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #bbb;
    font-size: 14px;
}

.msg-container {
    padding: 12px;
    background-color: #e4e6eb;
    border-radius: 4px;
    max-width: 400px;
    min-height: 40px;
    word-break: break-all;
    overflow-wrap: break-word;
}
</style>