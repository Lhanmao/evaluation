<template>
  <div class="container" style="background-color: #f2f3f5;">
    <el-container>
      <el-header style="background-color: #4c535a;height: 250px;" class="login-container">
        <div style="display: flex;padding: 10px;align-items: center;">
          <img src="@/assets/logo.png" alt="" style="width:40px;position: relative;">
          <span style="font-size: 18px;margin-left: 10px;color:white;font-weight: 500;">鞋评测</span>
        </div>

        <div style="width: 500px;display: block;margin-left: auto;margin-right: auto;margin-top: 70px;">
          <el-input placeholder="请输入标题内容" v-model="titleSearch" class="input-with-select" prefix-icon="el-icon-search"
            size="medium" @keyup.enter.native="toSearch">
            <el-button slot="append" @click="toSearch()">搜索</el-button>
          </el-input>
        </div>

      </el-header>

      <div v-if="isSticky == true">
        <div :class="{ 'is-sticky': isSticky }" style="display:inline-block;">
          <el-container style="background-color: #ffffff;">
            <aside>
              <div style="padding-left: 10px;">
                <img src="@/assets/logo.png" alt="" style="width:40px;position: relative;top: 10px;">
                <span style="font: 20px;margin-left: 12px;color:black;font-weight: 550;">鞋评测</span>
              </div>
            </aside>
            <aside style="margin-left: auto;margin-right: auto;">
              <el-menu :default-active="activeIndex" router mode="horizontal" @select="handleSelect"
                background-color="#ffffff" text-color="#fff" active-text-color="#1e80ff"
                style="border-bottom: none !important;">
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
              <!-- <div style="width: 100%;height: 100%;"> -->
              <div style="float: left;display: flex;padding-top: 8px;margin-right: 10px;">
                <el-button type="primary" round @click="pubEvaluation">
                  发表测评
                </el-button>
              </div>
              <div style="height: 50px;float: left;display: flex;">
                <div style="height:50px;margin-right: 10px;cursor: pointer;">
                  <el-popover placement="top-start" trigger="hover" content="系统公告">
                    <span class="item-notice" slot="reference" @click="opNotice">
                      <i class="el-icon-message-solid"></i>
                    </span>
                  </el-popover>

                </div>
                <div v-if="openNotice == true">
                  <Notice :openNotice.sync="openNotice"></Notice>
                </div>

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
              <!-- </div> -->
            </aside>
          </el-container>
        </div>
      </div>
    </el-container>

    <el-container>
      <div>
        <div class="sidebar" :class="{ 'is-fixed': isFixed }">
          <el-aside style="overflow:hidden;min-height: 100vh;background-color: #ffffff;width:200px;">
            <el-menu default-active="/home" router background-color="#ffffff" text-color="black"
              active-text-color="#1e80ff">
              <el-menu-item index="/home">
                <template>
                  <i class="el-icon-stopwatch"></i>
                  <span slot="title" style="font-size: 16px;">综合</span>
                </template>
              </el-menu-item>
              <el-menu-item index="/hotEva">
                <template slot="title">
                  <i class="el-icon-tickets"></i>
                  <span style="font-size: 16px;">测评热榜</span>
                </template>
              </el-menu-item>
              <el-submenu index="2">
                <template slot="title">
                  <i class="el-icon-goods"></i>
                  <span style="font-size: 16px;">运动品牌</span>
                </template>
                <el-menu-item-group>
                  <!-- <div v-for="brandItem in brandList" :key="brandItem.id"> -->
                  <el-menu-item v-for="(brandItem, index) in brandList" :key="index" :index="brandItem.path"
                    @click="clickMenu(brandItem.path)">
                    <span style="font-size: 15px;">{{ brandItem.name }}</span>
                  </el-menu-item>
                  <!-- </div> -->
                </el-menu-item-group>
              </el-submenu>
              <el-submenu v-if="user.user_type === '管理员'" index="3">
                <template slot="title">
                  <i class="el-icon-document"></i>
                  <span style="font-size: 16px;">测评管理</span>
                </template>
                <el-menu-item-group>
                  <el-menu-item index="/category">
                    <span style="font-size: 15px;">品牌信息</span>
                  </el-menu-item>
                  <el-menu-item index="/blog">
                    <span style="font-size: 15px;">文章管理</span>
                  </el-menu-item>
                  <el-menu-item index="/audit">
                    <span style="font-size: 15px;">审核管理</span>
                  </el-menu-item>
                  <el-menu-item index="/commentView">
                    <span style="font-size: 15px;">评论管理</span>
                  </el-menu-item>
                  <el-menu-item index="/session">
                    <span style="font-size: 15px;">私信管理</span>
                  </el-menu-item>
                </el-menu-item-group>
              </el-submenu>
              <el-submenu v-if="user.user_type === '管理员'" index="1">
                <template slot="title">
                  <i class="el-icon-s-custom"></i>
                  <span style="font-size: 16px;">系统管理</span>
                </template>
                <el-menu-item-group>
                  <el-menu-item index="/user">
                    <span style="font-size: 15px;">用户信息</span>
                  </el-menu-item>
                  <el-menu-item index="/notice">
                    <span style="font-size: 15px;">公告信息</span>
                  </el-menu-item>
                  <el-menu-item index="/admin">
                    <span style="font-size: 15px;">平台信息</span>
                  </el-menu-item>
                  <el-menu-item index="/logView">
                    <span style="font-size: 15px;">日志管理</span>
                  </el-menu-item>
                </el-menu-item-group>
              </el-submenu>
            </el-menu>
          </el-aside>

        </div>

      </div>
      <div :class="{ 'is-mainContext': isFixed }" style="width: 100%;background-color: #f2f3f5;">
        <el-main style="padding: 10px;width: 1060px;">
          <router-view />
        </el-main>
      </div>
    </el-container>

  </div>
</template>

<script>
import request from '@/utils/request';
import Notice from '@/components/Notice.vue'

export default {
  data() {
    return {
      titleSearch: '',
      activeIndex: '/home',//顶栏菜单默认首页
      isSticky: false,
      isFixed: false,
      isDarkMode: false,
      iconHome: '首页',
      iconHot: '热门',
      iconMess: '消息',
      iconUser: '个人中心',
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      isUser: true,
      avaUrl: '',
      switchValue: false,
      brandList: [],
      openNotice: false,
    }
  },
  components: {
    Notice
  },
  mounted() {
    window.addEventListener('scroll', this.handleScroll)
    this.isUser = localStorage.getItem("user") ? false : true
    this.avaUrl = 'http://localhost:8080/api/files/' + this.user.avatar
    this.findBrand();
  },
  destroyed() {
    window.removeEventListener('scroll', this.handleScroll)
  },
  methods: {
    findBrand() {
      request.get('/category/findAll').then(res => {
        if (res.code === '0') {
          this.brandList = res.data
          this.brandList.forEach(item => {
            this.$set(item, 'path', '/brand?category=' + item.name)
          })
          // console.log(this.brandList)
        }
      })
    },
    handleScroll() {
      //顶栏
      const scrollTop = window.pageYOffset || document.documentElement.scrollTop
      this.isSticky = scrollTop > 248 // 当页面滚动超过248px时启用固定
      const isFixed = scrollTop > 248
      this.isFixed = isFixed
    },
    handleSelect() {

    },
    redirectToLogin() {
      // 登录跳转
      this.$router.push('/login');
    },
    redirectRegist() {
      //注册跳转
      this.$router.push('/regist')
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
    pubEvaluation() {
      this.$router.push('/public')
    },
    toSearch() {
      this.$router.push('/search?title=' + this.titleSearch)
      // return '/about?title=' + this.titleSearch
    },
    clickMenu(obj) {
      this.$router.push(obj)
    },
    opNotice() {
      this.openNotice = true;
    }
  }


}
</script>

<style>
.item-notice {
  height: 90%;
  font-size: 25px;
  display: flex;
  align-items: center;
  color: #666;
}

.item-notice:hover {
  color: #1c1b1b;
}

.el-menu {
  border-right: none !important;
  color: #1e80ff;
}

.el-menu-item:hover {
  color: #1e80ff !important;
  background-color: #f4f6f9 !important;
}

.el-submenu__title:hover {
  color: #1e80ff !important;
  background-color: #f4f6f9 !important;
}

.container {
  height: 2000px;
  /* width: auto; */
  /* 设置容器高度，使得可以滚动 */
}

.sticky-header {
  position: relative;
  /* 设置顶部相对定位 */
}

.is-sticky {
  position: fixed;
  /* 设置固定定位 */
  top: 0;
  /* 设置固定在顶部 */
  width: 100%;
  z-index: 2;
}

.sidebar {
  width: 200px;
  /* 设置侧边栏宽度 */
  position: relative;
}

.is-fixed {
  position: fixed;
  /* 设置固定定位 */
  top: 0;
  /* 设置固定在顶部 */
  margin-top: 60px;
  /* 内容的相对位置 */
}

.is-mainContext {
  margin-top: 0;
  margin-left: 200px;
  position: relative;
  z-index: 1;
  /* width: 100%; */
}
</style>