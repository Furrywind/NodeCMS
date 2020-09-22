import Vue from "vue";
import VueRouter from "vue-router";

import Index from "@/views/Index.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    component: Index,
    children: [
      {
        path: "",
        name: "dashboard",
        component: () => import("@/views/Dashboard.vue")
      },
      {
        path: "articles",
        name: "articles",
        component: () => import("@/views/Articles.vue")
      },
      {
        path: "editor",
        name: "editor",
        component: () => import("@/views/Editor.vue")
      },
      {
        path: "category",
        name: "category",
        component: () => import("@/views/Category.vue")
      },
      {
        path: "labels",
        name: "labels",
        component: () => import("@/views/Labels.vue")
      },
      {
        path: "users",
        name: "users",
        component: () => import("@/views/Users.vue")
      },
      {
        path: "settings",
        name: "settings",
        component: () => import("@/views/Settings.vue")
      }
    ],
    beforeEnter: (to, from, next) => {
      if (localStorage.getItem("token")) {
        next();
      } else {
        next("/login");
      }
    }
  },
  {
    path: "/login",
    name: "login",
    // route level code-splitting
    // this generates a separate chunk (login.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "login" */ "@/views/Login.vue")
  }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

export default router;
