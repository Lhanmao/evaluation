<template>
    <div style="background-color: #f2f3f5;">
        <div style="margin-bottom: 1%;">
            <TopBar :activeIndex="'/center'"></TopBar>
        </div>
        <div>
            <div style="padding-left: 19%;">
                <div style="display: flex;gap: 30px;padding-bottom: 10px;">
                    <div class="tool-bar" :class="{ 'tool-bar-active': item.name === current }" v-for="item in barList"
                        :key="item.id" @click="clickBar(item.name)">
                        {{ item.name }}</div>
                </div>
            </div>
            <div class="card" style="width: 830px;height: auto;margin-left: auto;margin-right: auto;padding: 10px;">
                <div style="display: flex;gap: 10px;margin-bottom: 12px;margin-left: 7px;" v-if="current == '我的测评'">
                    <div class="tool-childbar" :class="{ 'tool-bar-active': item.name === curChildBar }"
                        v-for="item in childBarList" :key="item.id" @click="clickChildBar(item.name, item.id)">
                        {{ item.name }}</div>
                </div>
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
                                    <el-tag type="primary" style="margin-right: 10px;"
                                        v-for="T in JSON.parse(item.tags || '[]')" :key="T">
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

                    <div v-if="current == '我的测评'" style="margin-left: 15px;">
                        <div style="display: flex;flex-direction: column;gap: 8px;margin-top: 5px;">
                            <el-button type="primary" plain icon="el-icon-edit" size="medium"
                                @click="editBlog(item)"></el-button>
                            <el-button type="danger" plain style="margin-left: auto;margin-right: auto;width: 100%;"
                                icon="el-icon-delete" size="medium" @click="delBlog(item.id)"></el-button>
                        </div>
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
        <div>
            <el-dialog title="编辑测评" :visible.sync="dialogFormVisible" destroy-on-close>
                <el-form :model="form">
                    <el-form-item label="标题" label-width="15%" prop="title">
                        <el-input v-model="form.title" autocomplete="off" style="width: 90%;"
                            placeholder="标题"></el-input>
                    </el-form-item>
                    <el-form-item label="简介" label-width="15%" prop="descr">
                        <el-input type="textarea" v-model="form.descr" autocomplete="off" style="width: 90%;"
                            placeholder="简介"></el-input>
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
                        <div id="editor"></div>
                    </div>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="dialogFormVisible = false">取 消</el-button>
                    <el-button type="primary" @click="submit()">确 定</el-button>
                </div>
            </el-dialog>
        </div>
    </div>
</template>
<script>
import request from '@/utils/request';
import E from "wangeditor"
import hljs from "highlight.js"
import TopBar from '../components/TopBarView.vue'

export default {
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
            barList: [{ name: '我的测评' }, { name: '我的收藏' }, { name: '我的点赞' }, { name: '我的评论' }],
            current: '我的测评',
            childBarList: [{ id: '1', name: '已发布' }, { id: '-1', name: '正在审核' }, { id: '0', name: '审核未通过' }],
            curChildBar: '已发布',
            params: {//查询、分页参数
                state: '',
                pageNum: 1,
                pageSize: 10
            },
            total: 0,
            tableData: [],
            currUser: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : '{}',
            tagsArr: [],
            dialogFormVisible: false,
            form: {},
            categoryList: [],
            editor: null
        }
    },
    // 修改整个浏览器的背景颜色样式
    beforeCreate() {
        this.$nextTick(() => {
            // document.body.style.backgroundColor = '#333';
            // document.body.style.color = '#fff';
            document.body.setAttribute('style', 'background:#f2f3f5')
        })
    },
    beforeDestroy() {
        document.body.removeAttribute('style')
    },
    created() {
        this.params.user_id = this.currUser.user_id
        this.current = '我的测评'
        this.curChildBar = '已发布'
        this.params.state = '1'
        this.params.user_id = this.currUser.user_id

        this.findBySearch()
    },
    components: {
        TopBar
    },
    methods: {
        submit() {
            this.form.tags = JSON.stringify(this.tagsArr)
            this.form.content = this.editor.txt.html()
            // console.log(this.form)
            this.form.state = '-1'
            request.post("/blog/add", this.form).then(res => {
                if (res.code === '0') {
                    this.$message.success("编辑成功");
                    this.dialogFormVisible = false;
                    this.findBySearch();
                } else {
                    this.$message.error(res.msg)
                }
            })
        },
        editBlog(obj) {
            this.form = JSON.parse(JSON.stringify(obj));
            this.tagsArr = JSON.parse(this.form.tags) || [];
            this.dialogFormVisible = true;
            this.setRichText();
            setTimeout(() => {
                this.editor.txt.html(this.form.content)
            }, 0)
            // console.log(this.form)
        },
        delBlog(id) {
            this.$confirm('是否删除本条测评?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'error'
            }).then(() => {
                request.delete("/blog/delete/" + id).then(res => {
                    if (res.code === '0') {
                        this.$message.success("删除成功");
                        this.findBySearch();
                    } else {
                        this.$message.error(res.msg)
                    }
                })
            }).catch(() => {
                this.$message.info("已取消删除");
            });

        },
        findBySearch() {
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
            request.get("/category/findAll").then(res => {
                this.categoryList = res.data || []
            })
        },
        // 切换工具栏
        clickBar(barName) {
            this.current = barName
            if (this.current === '我的测评') {
                this.curChildBar = '已发布'
                this.params.state = '1'
                this.params.user_id = this.currUser.user_id
                this.findBySearch();
            }
            else if (this.current === '我的收藏') {
                this.params.user_id = this.currUser.user_id
                request.get("/blog/searchCollect", {
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
            }
            else if (this.current === '我的点赞') {
                this.params.user_id = this.currUser.user_id
                request.get("/blog/searchLike", {
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
            }
            else {
                this.params.user_id = this.currUser.user_id
                request.get("/blog/searchMyComment", {
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
            }

        },
        clickChildBar(barName, id) {
            this.curChildBar = barName
            this.params.state = id
            this.findBySearch();
            // console.log(id)

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
        setRichText() {
            this.$nextTick(() => {
                this.editor = new E('#editor')
                this.editor.highlight = hljs
                this.editor.config.uploadImgServer = 'http://localhost:8080/api/files/editor/upload'
                this.editor.config.uploadFileName = 'file'
                this.editor.config.uploadImgParams = {
                    type: 'img'
                }
                this.editor.create()
            })
        },
        //图片上传回调函数
        handleCoverSuccess(res) {
            this.form.cover = res.data
        },
    }
}
</script>
<style scoped>
.tool-bar {
    font-size: 17px;
    cursor: pointer;
    padding: 4px;
}

.tool-childbar {
    cursor: pointer;
    padding: 3px;
}

.tool-bar-active {
    background-color: #1890ff;
    color: #fff;
    border-radius: 5px;
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