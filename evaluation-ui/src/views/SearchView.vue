<template>
  <div class="container" style="background-color: #f2f3f5;">
    <TopBar></TopBar>
    <div>
      <div style="display: flex;gap: 25px;padding-top: 24px;padding-left: 10%;">
        <div style="display: flex;flex-direction: column;gap: 20px;">
          <div class="card" style="width: 830px;">
            <div style="padding-top: 18px;padding-right: 2.5rem;padding-left: 2rem;">
              <div style="display: flex;border-bottom: 1px solid #ddd;padding: 12px;cursor: pointer;"
                v-if="tableData.length === 0">暂无相关数据</div>
              <div style="display: flex;border-bottom: 1px solid #ddd;padding: 12px;cursor: pointer;"
                v-for="item in tableData" :key="item.id" class="botimg">
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
                        <span style="color: #666;margin-right: 20px;"><i class="el-icon-user"></i>
                          {{ item.userName }}</span>
                        <span style="color: #666;margin-right: 20px;"><i class="el-icon-eye"></i>
                          {{ item.read_count }}</span>
                        <span style="color: #666;margin-right: 20px;"><i class="el-icon-like"></i>
                          {{ item.likeNum }}</span>
                      </div>
                      <div style="width: fit-content;">
                        <el-tag type="primary" style="margin-right: 10px;" v-for="T in JSON.parse(item.tags || '[]')"
                          :key="T">
                          {{ T }}</el-tag>
                      </div>
                    </div>
                  </a>
                </div>
                <div style="width: 100px;height:77px">
                  <img style="width: 100%;height:100%;border-radius: 5px;"
                    :src="'http://localhost:8080/api/files/' + item.cover" alt="" onerror="this.style.display='none'">
                </div>
              </div>
              <div class="block" style="margin: 13px;">
                <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                  :current-page="params.pageNum" :page-sizes="[5, 10, 15, 20]" :page-size="params.pageSize"
                  layout="total, sizes, prev, pager, next, jumper" :total="total">
                </el-pagination>
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
import TopBar from '../components/TopBarView.vue'

export default {
  data() {
    return {
      params: {//查询、分页参数
        pageNum: 1,
        pageSize: 10
      },
      title: '',//地址栏获取文章标题
      tableData: [],
      total: 0,
    }
  },
  components: {
    TopBar,
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
    this.title = this.$route.query.title
    this.findBySearch()
  },
  methods: {
    //查表
    findBySearch() {
      this.params.title = this.title
      request.get("/blog/search", {
        params: this.params
      }).then(res => {
        if (res.code === '0') {
          this.tableData = res.data.list;
          this.total = res.data.total;
        } else {

        }
      })
      request.get("/category/findAll").then(res => {
        this.categoryList = res.data || []
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
    this.title = to.query.title
    this.findBySearch()
    next();
  }
}
</script>
<style scoped></style>