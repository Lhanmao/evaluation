<template>
  <div style="display: flex;gap: 18px;width: 100%;">
    <div style="flex: 1;width: 72%;" class="card">
      <div style="display: flex;border-bottom: 1px solid #ddd;padding: 12px;cursor: pointer;" v-for="item in tableData"
        :key="item.id" class="botimg">
        <div style="flex: 1;width: 68%;">
          <a :href="getGoodsHref(item.id)" class="a-title">
            <div style="font-size: 17px;font-weight: bold;margin-bottom: 7px;">{{ item.title }}</div>
          </a>
          <a :href="getGoodsHref(item.id)">
            <div class="line1" style="color: #666;font-size: 15px;margin-bottom: 8px;">{{ item.descr }}</div>
            <div style="display: flex;">
              <div style="flex: 1;font-size: 15px;">
                <span style="color: #666;margin-right: 20px;"><i class="el-icon-user"></i>{{ item.userName }}</span>
                <span style="color: #666;margin-right: 20px;"><i class="el-icon-eye"></i>{{ item.read_count }}</span>
                <span style="color: #666;margin-right: 20px;"><i class="el-icon-like"></i>
                  {{ item.likeNum }}</span>
              </div>
              <div style="width: fit-content;">
                <el-tag type="primary" style="margin-right: 10px;" v-for="T in JSON.parse(item.tags || '[]')" :key="T">
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
          :current-page="params.pageNum" :page-sizes="[10, 20, 30, 40]" :page-size="params.pageSize"
          layout="total, sizes, prev, pager, next, jumper" :total="total">
        </el-pagination>
      </div>
    </div>

    <div style="flex-direction: column;width: 22%;height: 700px;">
      <div style="width:100%;height: 19%;margin-bottom: 9%;" class="card_right">
        <div style="display: flex;gap:17px;padding: 16px;flex-direction: column;">
          <div style="display: flex;flex-direction: column;">
            <span style="font-size: 19px;font-weight: 550;line-height: 24px;margin-bottom: 8px;"
              v-if="curUserName != '{}'">
              {{ curUserName }},上午好！</span>
            <span style="font-size: 19px;font-weight: 550;line-height: 24px;margin-bottom: 8px;" v-else>
              上午好！</span>
            <span style="font-size: 14px;color: #666;font-weight: 400;">点亮平台每一天</span>
          </div>
          <div style="margin-left: auto;margin-right: auto;">
            <el-button type="primary" plain size="medium">签到</el-button>
          </div>
        </div>
      </div>

      <div style="width:100%;height: 76%;" class="card_right">
        <div class="hot-item-header">
          <div style="padding-top: 12px;">
            <span style="color: #666;margin-right: 8px;"><i class="el-icon-user"></i></span>
            <span style="font-size: 18px;">测评榜</span>
          </div>
          <div style="padding-top: 12px;">
            <el-button type="text" size="medium" icon="el-icon-refresh" @click="haveAChange()">换一换</el-button>
          </div>
        </div>

        <div style="margin-left: 8px;margin-right: 8px;border-bottom: 1px solid #ddd;padding: 5px;"></div>

        <div style="display: flex;padding: 7px;margin-left: 8px;margin-right: 8px;margin-top: 10px;"
          v-for="(hot, i) in hotData" :key="hot.id" class="botimg">
          <a :href="getGoodsHref(hot.id)">
            <div>
              <span style="margin-right: 10px;">{{ i + 1 }}</span>
            </div>
          </a>
          <span class="line1" style="width: 173px;">
            <a :href="getGoodsHref(hot.id)">
              <div style="color: #666;font-size: 15px;margin-bottom: 2px;" class="line1">
                {{ hot.descr }}
              </div>
            </a>
          </span>
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
      hotRink: 1,
      params: {//查询、分页参数
        pageNum: 1,
        pageSize: 10
      },
      hotParams: {//查询、分页参数
        pageNum: 1,
        pageSize: 10
      },
      total: 0,
      tableData: [],
      hotData: [],
      curUserName: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")).user_name : '{}',
    }
  },
  created() {
    this.findBySearch();
    this.findHot();
  },
  methods: {
    //查表
    findBySearch() {
      this.params.state = 1
      request.get("/blog/search", {
        params: this.params
      }).then(res => {
        if (res.code === '0') {
          this.tableData = res.data.list;
          this.total = res.data.total;
          // console.log(this.tableData)
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    //查热搜榜
    findHot() {
      // console.log(this.hotParams)
      request.get("/blog/hotSearch", {
        params: this.hotParams
      }).then(res => {
        if (res.code === '0') {
          this.hotData = res.data.list;
          // console.log(this.hotData)
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
    },
    // 换一换
    haveAChange() {
      if (this.hotParams.pageNum == 1) {
        console.log("123123")
        this.hotParams.pageNum = 2;
      } else {
        this.hotParams.pageNum = 1;
      }
      this.findHot();
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