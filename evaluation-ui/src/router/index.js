import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import AuditView from '@/views/system/AuditView.vue';
import PeopleNum from '../views/system/PeopleNum.vue';
import UserView from "../views/system/UserView.vue";
import LogView from "../views/system/LogView.vue";
import CategoryView from "../views/system/CategoryView.vue"
import SessionView from '@/views/system/SessionView.vue';
import BlogView from "../views/system/BlogView.vue"
import CommentView from "../views/system/CommentView.vue"
import NoticeView from "../views/system/NoticeView.vue"
import UserInfoView from "../views/userInfo/UserInfoView.vue";
import LoginView from "../views/userLogin/LoginView.vue";
import RegisterView from "../views/userLogin/RegisterView.vue";
import RePwd from "../views/userLogin/RePwd.vue";
import LayoutView from "../views/Layout.vue";
import PublicView from "../views/PublicView.vue";
import BlogShowView from "../views/BlogShowView.vue"
import PersonalCenterView from "../views/PersonalCenterView.vue";
import BrandView from "../views/BrandView.vue"
import DataVisionView from "../views/DataVisionView.vue"
import HotEvaView from '@/views/HotEvaView.vue';
import ChatView from '@/views/ChatView.vue';

Vue.use(VueRouter)

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: LoginView
  },
  {
    path: '/',
    // name: 'Layout',
    component: LayoutView,
    children: [
      {
        path: 'home',
        name: 'home',
        component: HomeView
      },
      {
        path: 'admin',
        name: 'admin',
        component: PeopleNum
      },
      {
        path: 'user',
        name: 'user',
        component: UserView
      },
      {
        path: 'userInfo',
        name: 'userInfo',
        component: UserInfoView
      },
      {
        path: 'logView',
        name: 'logView',
        component: LogView
      },
      {
        path: 'category',
        name: 'categoryView',
        component: CategoryView
      },
      {
        path: 'blog',
        name: 'blogView',
        component: BlogView
      },
      {
        path: 'commentView',
        name: 'CommentView',
        component: CommentView
      },
      {
        path: 'brand',
        name: 'BrandView',
        component: BrandView
      },
      {
        path: 'hotEva',
        name: 'HotEvaView',
        component: HotEvaView
      },
      {
        path: 'audit',
        name: 'AuditView',
        component: AuditView
      },
      {
        path: 'session',
        name: 'SessionView',
        component: SessionView
      },
      {
        path: 'notice',
        name: 'NoticeView',
        component: NoticeView
      }
    ]
  },
  {
    path: '/regist',
    name: 'regist',
    component: RegisterView
  },
  {
    path: '/public',
    name: 'PublicView',
    component: PublicView
  },
  {
    path: '/rePwd',
    name: 'rePwd',
    component: RePwd
  },
  {
    path: '/blogShow',
    name: 'blogShow',
    component: BlogShowView
  },
  {
    path: '/center',
    name: 'PersonalCenterView',
    component: PersonalCenterView
  },
  {
    path: '/search',
    name: 'search',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/SearchView.vue')
  },
  {
    path: '/dataVision',
    name: 'DataVisionView',
    component: DataVisionView
  },
  {
    path: '/chat',
    name: 'ChatView',
    component: ChatView
  }
]

//跳转页面滚动到顶端
const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  scrollBehavior: () => ({ y: 0 }), //滚动到顶端
  routes
})

//路由守卫
//前端不安全，可以人为篡改localstorage,必须使用jwt
router.beforeEach((to, from, next) => {
  if (to.path === '/login' || to.path === '/home' || to.path === '/blank') {
    next();
  }
  if (to.path === '/regist' || to.path === '/rePwd' || to.path === '/blogShow') {
    next();
  }
  const user = localStorage.getItem("user");
  if (!user) {
    if (to.path === '/login') {
      return next("/login");
    }
    else if (to.path === '/regist') {
      return next("/regist");
    }
    else if (to.path === '/home') {
      return next("/home");
    }
    else if (to.path === '/blank') {
      return next("/blank");
    }
    else if (to.path === '/rePwd') {
      return next("/rePwd");
    }
    else if (to.path === '/blogShow') {
      return next("/blogShow")
    }
    else {
      return next("/login");
    }

  }
  if (JSON.parse(user).user_type != '管理员') {
    if (to.path === '/user') {
      return next("/home")
    }
  }
  next();
})

//解决重定向bug
const originalPush = VueRouter.prototype.push;
VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch((err) => err);
};

export default router
