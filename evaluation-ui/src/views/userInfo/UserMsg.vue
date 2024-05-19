<template>
    <el-form ref="form" :model="user" :rules="rules" label-width="80px">
        <el-form-item label="用户昵称" prop="nick_name">
            <el-input v-model="user.nick_name" maxlength="30" />
        </el-form-item>
        <el-form-item label="手机号码" prop="phone">
            <el-input v-model="user.phone" maxlength="11" />
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
            <el-input v-model="user.email" maxlength="50" />
        </el-form-item>
        <el-form-item label="性别">
            <el-radio-group v-model="user.gender">
                <el-radio label="男">男</el-radio>
                <el-radio label="女">女</el-radio>
            </el-radio-group>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" size="mini" @click="submit">保存</el-button>
            <el-button type="danger" size="mini" @click="close">关闭</el-button>
        </el-form-item>
    </el-form>
</template>

<script>
import request from '@/utils/request';

export default {
    props: {
        cuser: {
            type: Object
        }
    },
    data() {
        return {
            // 表单校验
            rules: {
                nick_name: [
                    { required: true, message: "用户昵称不能为空", trigger: "blur" }
                ],
                phone: [
                    { required: true, message: "手机号码不能为空", trigger: "blur" },
                    {
                        pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
                        message: "请输入正确的手机号码",
                        trigger: "blur"
                    }
                ]
            },
            user: {}
        };
    },
    created() {
        this.user = JSON.parse(JSON.stringify(this.cuser))
    },
    methods: {
        submit() {
            request.post("/user/add", this.user).then(res => {
                if (res.code === '0') {
                    this.$message({
                        message: "保存成功",
                        type: 'success'
                    });
                    // 修改当前用户的信息，方便渲染到页面
                    localStorage.setItem("user", JSON.stringify(this.user));
                    // 更新数据后刷新信息
                    this.$emit('refresh')
                } else {
                    this.$message({
                        message: res.msg,
                        type: 'error'
                    })
                }
            })
        },
        close() {

        }
    }
};
</script>