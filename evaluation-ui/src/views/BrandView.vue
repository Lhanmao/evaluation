<template>
    <div style="display: flex;gap: 18px;width: 100%;">
        <div style="flex: 1;width: 72%;" class="card">
            <div style="display: flex;border-bottom: 1px solid #ddd;padding: 15px;margin-left: 10px;"
                v-if="tableData.length === 0">暂无相关数据
            </div>
            <div style="display: flex;border-bottom: 1px solid #ddd;padding: 12px;cursor: pointer;"
                v-for=" item  in  tableData " :key="item.id" class="botimg">
                <div style="flex: 1;width: 68%;">
                    <a :href="getGoodsHref(item.id)" class="a-title">
                        <div style="font-size: 17px;font-weight: bold;margin-bottom: 7px;">
                            {{ item.title }}
                        </div>
                    </a>
                    <a :href="getGoodsHref(item.id)">
                        <div class="line1" style="color: #666;font-size: 15px;margin-bottom: 8px;">
                            {{ item.descr }}
                        </div>
                        <div style="display: flex;">
                            <div style="flex: 1;font-size: 15px;">
                                <span style="color: #666;margin-right: 20px;">
                                    <i class="el-icon-user"></i>
                                    {{ item.userName }}</span>
                                <span style="color: #666;margin-right: 20px;">
                                    <i class="el-icon-eye"></i>
                                    {{ item.read_count }}</span>
                                <span style="color: #666;margin-right: 20px;">
                                    <i class="el-icon-like"></i>{{ item.likeNum }}</span>
                            </div>
                            <div style="width: fit-content;">
                                <el-tag type="primary" style="margin-right: 10px;"
                                    v-for=" T  in  JSON.parse(item.tags || '[]') " :key="T">
                                    {{ T }}</el-tag>
                            </div>
                        </div>
                    </a>
                </div>
                <div style="width: 100px;height:77px">
                    <img style="width: 100%;height:100%;border-radius: 5px;"
                        :src="'http://localhost:8080/api/files/' + item.cover" alt=""
                        onerror="this.style.display='none'">
                </div>

            </div>
            <div class="block" style="margin: 13px;">
                <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                    :current-page="params.pageNum" :page-sizes="[10, 20, 30, 40]" :page-size="params.pageSize"
                    layout="total, sizes, prev, pager, next, jumper" :total="total">
                </el-pagination>
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
                pageSize: 10
            },
            total: 0,
            tableData: [],
            brand: '',//从地址栏获取品牌名称
            brandName: ''
        }
    },
    created() {
        this.brand = this.$route.query.category
        this.findBySearch();
    },
    methods: {
        //查表
        findBySearch() {
            this.params.categoryName = this.brand;
            this.params.state = 1
            request.get("/blog/search", {
                params: this.params
            }).then(res => {
                if (res.code === '0') {
                    this.tableData = res.data.list;
                    this.total = res.data.total;
                } else {
                    this.$message.error(res.msg)
                }
            })
        },
        //分页功能
        handleSizeChange(pageSize) {
            this.params.pageSize = pageSize;
            this.params.pageNum = 1;
            this.findBySearch();
        },
        handleCurrentChange(pageNum) {
            this.params.pageNum = pageNum;
            this.findBySearch();
        },
        getGoodsHref: function (val) {
            return '/blogShow?blogId=' + val
        }
    },
    beforeRouteUpdate(to, from, next) {
        // 在这里执行刷新页面的逻辑
        // console.log(to.query.category)
        this.brand = to.query.category
        this.findBySearch()
        next();
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