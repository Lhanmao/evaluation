<template>
    <div>
        <el-drawer title="系统公告" :visible.sync="openNotice" direction="rtl" size="50%" :append-to-body="true"
            :before-close="closeNotice">
            <div style="padding: 20px;">
                <el-collapse v-model="activeNames" @change="handleChange">
                    <el-collapse-item :title="item.title" :name="item.id" v-for="item in noticeData" :key="item.id">
                        <div>{{ item.content }}</div>
                        <div>{{ item.create_date }}</div>
                    </el-collapse-item>

                </el-collapse>
            </div>
        </el-drawer>
    </div>
</template>
<script>
import request from '@/utils/request';

export default {
    props: {
        openNotice: Boolean
    },
    data() {
        return {
            table: false,
            activeNames: '',
            open: false,
            noticeData: []
        }
    },
    mounted() {
        this.findAll()
    },
    methods: {
        closeNotice() {
            this.$emit('update:openNotice', false)
        },
        findAll() {
            request.get("/notice/findAll").then(res => {
                if (res.code === '0') {
                    this.noticeData = res.data
                    this.activeNames = this.noticeData[0].id
                }
            })
        },
        handleChange() {

        }
    }
}
</script>