<template>
    <div style="display: flex;gap: 18px;width: 100%;">
        <div style="flex: 1;width: 72%;" class="card">
            <div style="display: flex;border-bottom: 1px solid #ddd;padding: 12px;cursor: pointer;"
                v-for="item in hotData" :key="item.id" class="botimg">
                <div style="flex: 1;width: 68%;">
                    <a :href="getGoodsHref(item.id)" class="a-title">
                        <div style="font-size: 17px;font-weight: bold;margin-bottom: 7px;">
                            {{ item.title }}
                        </div>
                    </a>
                    <a :href="getGoodsHref(item.id)">
                        <!-- <div class="line1" style="color: #666;font-size: 15px;margin-bottom: 8px;">
                            {{ item.descr }}
                        </div> -->
                        <div style="display: flex;">
                            <div style="font-size: 15px;">
                                <span style="color: #666;margin-right: 20px;"><i class="el-icon-user"></i>
                                    {{ item.userName }}</span>
                                <span style="color: #666;margin-right: 20px;"><i class="el-icon-eye"></i>
                                    {{ item.read_count }}</span>
                                <span style="color: #666;margin-right: 20px;"><i class="el-icon-like"></i>
                                    {{ item.likeNum }}</span>
                            </div>
                            <div>
                                <el-tag type="primary" style="margin-right: 10px;"
                                    v-for="T in JSON.parse(item.tags || '[]')" :key="T">
                                    {{ T }}</el-tag>
                            </div>
                        </div>
                    </a>
                </div>
                <div style="width: fit-content;margin-top: auto;margin-bottom: auto;">
                    <div style="display: flex;">
                        <div style="margin-top: auto;margin-bottom: auto;height: 100%;">
                            <span style="margin-right: 8px;color: red;">
                                <i class="el-icon-magic-stick"></i>
                            </span>
                            <span style="color: #252933;font-size: 1.35rem;margin-right: 8px;">{{ item.people_like
                                }}</span>
                            <span style="color: #8a919f;">热度</span>
                        </div>
                        <div style="padding: 10px;">
                            <div class="el-divider el-divider--vertical" style="height: 300%;width: 1px;bottom: 90%;">
                            </div>
                        </div>
                        <el-button type="primary" plain size="medium" @click="collectHot()">收藏</el-button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import request from '@/utils/request';

export default {
    data() {
        return {
            params: {//查询、分页参数
                pageNum: 1,
                pageSize: 15
            },
            total: 0,
            tableData: [],
            hotData: [],
            curUserName: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")).user_name : '{}',
        }
    },
    created() {
        this.findHot();
    },
    methods: {
        //查热搜榜
        findHot() {
            request.get("/blog/hotSearch", {
                params: this.params
            }).then(res => {
                if (res.code === '0') {
                    this.hotData = res.data.list;
                    this.total = res.data.total;
                    // console.log(this.hotData)
                } else {
                    this.$message.error(res.msg)
                }
            })
        },
        getGoodsHref: function (val) {
            return '/blogShow?blogId=' + val
        },
        collectHot() {
            this.$message.success("收藏成功")
        }
    }
}
</script>

<style>
.hot-item-header {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    margin-top: 1rem;
    align-items: center;
    padding-right: 8px;
    padding-left: 8px;
}

.botimg:hover {
    text-decoration: none !important;
    display: inline-block;
    /*跟随父元素的高度*/
    /* height: inherit; */
    /* color: #1e80ff !important; */
    background-color: #f4f6f9 !important;
}

a {
    text-decoration: none;
    color: inherit;
}

.a-title:hover {
    text-decoration: underline;
}
</style>