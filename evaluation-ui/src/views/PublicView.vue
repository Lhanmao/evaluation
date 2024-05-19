<template>
    <div style="background-color: #f2f3f5;">
        <div style="margin-bottom: 1%;">
            <TopBar></TopBar>
        </div>
        <div class="card" style="width: 830px;height: 800px;margin-left: auto;margin-right: auto;">
            <div style="padding-top: 3%;">
                <div style="width: 100%;margin-bottom: 20px;">
                    <span style="font-size: 18px;font-weight: 560;padding-left: 380px;">发表测评</span>
                </div>
                <el-form :model="form" :rules="rules" ref="ruleForm">
                    <el-form-item label="标题" label-width="15%" prop="title">
                        <el-input v-model="form.title" autocomplete="off" style="width: 90%;"
                            placeholder="请输入测评标题"></el-input>
                    </el-form-item>
                    <el-form-item label="简介" label-width="15%" prop="descr">
                        <el-input type="textarea" v-model="form.descr" autocomplete="off" style="width: 90%;"
                            placeholder="请输入测评简介"></el-input>
                    </el-form-item>
                    <el-form-item label="封面" label-width="15%" prop="cover">
                        <el-upload :action="'http://localhost:8080/api/files/upload'" list-type="picture"
                            :on-success="handleCoverSuccess">
                            <el-button type="primary">上传封面</el-button>
                        </el-upload>
                    </el-form-item>
                    <el-form-item label="品牌" label-width="15%" prop="category_id">
                        <el-select v-model="form.category_id" style="width: 90%;">
                            <el-option v-for="item in categoryList" :key="item.id" :value="item.id"
                                :label="item.name"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="标签" label-width="15%">
                        <el-select v-model="tagsArr" multiple filterable allow-create default-first-option
                            style="width: 90%;">
                            <el-option v-for="temp in tagOption" :key="temp.value" :label="temp.label"
                                :value="temp.value"></el-option>
                        </el-select>
                    </el-form-item>
                    <div class="el-form-item el-form-item--small" label="内容" prop="content">
                        <div id="editor" style="padding-right: 10px;padding-left: 10px;position: relative;z-index: 1;">
                        </div>
                    </div>
                </el-form>
                <div style="margin-left: 330px;margin-top: 20px;">
                    <el-button @click="cancelToHome()" size="medium">取 消</el-button>
                    <el-button type="primary" @click="submit()" size="medium">发表</el-button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import request from '@/utils/request';
import E from "wangeditor"
import hljs from "highlight.js"
import TopBar from "../components/TopBarView.vue";

export default {
    name: "Public",
    data() {
        return {
            tagOption: [{
                value: '篮球鞋',
            }, {
                value: "足球鞋"
            }, {
                value: '休闲鞋'
            }, {
                value: '通勤鞋'
            }],
            form: {},
            categoryList: [],
            tagsArr: [],
            editor: null,
            rules: {
                title: [{
                    required: true, message: '请输入测评标题', trigger: 'blur'
                }],
                descr: [{
                    required: true, message: '请输入测评简介', trigger: 'blur'
                }, { min: 10, max: 80, message: '长度在 10 到 80 个字', trigger: 'blur' }],
                category_id: [{ required: true, message: '请选择品牌', trigger: 'change' }]
            },
            ruleForm: {
                title: '',
                descr: '',
                category_id: '',
            }
        }
    },
    components: {
        TopBar
    },
    created() {
        this.setRichText();
        this.findCategory();

    },
    methods: {
        findCategory() {
            request.get("/category/findAll").then(res => {
                if (res.code === '0') {
                    this.categoryList = res.data || []
                    console.log(this.categoryList)
                }
                else {
                    this.$message.error(res.msg)
                }
            })

        },
        //提交功能
        submit() {
            this.form.tags = JSON.stringify(this.tagsArr)
            this.form.content = this.editor.txt.html()
            console.log(this.form)
            request.post("/blog/add", this.form).then(res => {
                if (res.code === '0') {
                    this.$message.success("发表成功");
                    this.$router.push('/home')
                } else {
                    this.$message.error(res.msg)
                }
            })

        },
        //图片上传回调函数
        handleCoverSuccess(res) {
            this.form.cover = res.data
        },
        setRichText() {
            this.$nextTick(() => {
                this.editor = new E('#editor')
                this.editor.highlight = hljs
                this.editor.config.uploadImgServer = 'http://localhost:8080/api/files/editor/upload'
                this.editor.config.uploadFileName = 'file'
                // this.editor.config.uploadImgHeaders={

                // }
                this.editor.config.uploadImgParams = {
                    type: 'img'
                }
                this.editor.create()
            })
        },
        cancelToHome() {
            this.$router.push('/home')
        }
    }
}
</script>
<style scoped></style>