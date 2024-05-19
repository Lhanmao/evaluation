<template>
    <div>
        <div>
            <div style="margin-bottom: 15px;">
                <el-input v-model="params.title" style="width: 200px;margin-right: 2px;" placeholder="请输入标题"
                    @change="findBySearch()"></el-input>
                <el-input v-model="params.name" style="width: 200px;margin-right: 2px;" placeholder="请输入发布用户"
                    @change="findBySearch()"></el-input>
                <el-input v-model="params.categoryName" style="width: 200px;margin-right: 2px;" placeholder="请输入品牌名称"
                    @change="findBySearch()"></el-input>
                <el-button type="warning" round style="margin-left:5px" @click="findBySearch()">查询</el-button>
                <el-button type="warning" round style="margin-left:5px" @click="reset()">重置</el-button>
                <el-button type="primary" round style="margin-left:10px" @click="add()">新增</el-button>
                <el-popconfirm title="确定批量删除吗？" @confirm="delBatch()">
                    <el-button slot="reference" type="danger" round style="margin-left: 5px;">批量删除</el-button>
                </el-popconfirm>
            </div>
            <div>
                <el-table :data="tableData" height="420" border style="width: 100%"
                    @selection-change="handleSelectionChange" ref="table" :row-key="getRowKeys">
                    <el-table-column type="selection" width="45" ref="table" :reserve-selection="true">
                    </el-table-column>
                    <el-table-column prop="title" label="标题" width="90px">
                    </el-table-column>
                    <el-table-column prop="descr" label="简介" width="180px">
                    </el-table-column>
                    <el-table-column prop="cover" label="封面" width="90px">
                        <template v-slot="scope">
                            <div style="display: flex;align-items: center;">
                                <el-image style="width: 50px;height: 50px;border-radius: 5px;" v-if="scope.row.cover"
                                    :src="'http://localhost:8080/api/files/' + scope.row.cover"
                                    :preview-src-list="['http://localhost:8080/api/files/' + scope.row.cover]"></el-image>
                            </div>
                        </template>
                    </el-table-column>
                    <el-table-column prop="categoryName" label="品牌" width="90px">
                    </el-table-column>
                    <el-table-column prop="tags" label="标签" width="90px">
                        <template v-slot="scope">
                            <el-tag v-for="tagitem in JSON.parse(scope.row.tags || '[]')" :key="tagitem"
                                style="margin-right: 5px;">{{ tagitem }}</el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column prop="userName" label="发布用户" width="90px">
                    </el-table-column>
                    <el-table-column prop="date" label="发布日期" width="90px">
                    </el-table-column>
                    <el-table-column prop="read_count" label="浏览量" width="60px">
                    </el-table-column>

                    <el-table-column label="操作">
                        <template slot-scope="scope">
                            <el-button type="primary" round @click="edit(scope.row)">编辑</el-button>
                            <el-popconfirm title="确定删除吗？" @confirm="del(scope.row.id)">
                                <el-button slot="reference" type="danger" round style="margin-left: 5px;">删除</el-button>
                            </el-popconfirm>
                        </template>
                    </el-table-column>
                </el-table>
            </div>
            <div class="block" style="margin-top: 10px;">
                <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                    :current-page="params.pageNum" :page-sizes="[5, 10, 15, 20]" :page-size="params.pageSize"
                    layout="total, sizes, prev, pager, next, jumper" :total="total">
                </el-pagination>
            </div>
        </div>
        <div>
            <el-dialog title="新增测评文章" :visible.sync="dialogFormVisible" destroy-on-close>
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
                    <!-- <el-from-item label="内容" prop="content"> -->
                    <div class="el-form-item el-form-item--small" label="内容" prop="content">
                        <div id="editor"></div>
                    </div>
                    <!-- </el-from-item> -->
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
            input: "",
            params: {//查询、分页参数
                title: '',
                pageNum: 1,
                pageSize: 5
            },
            tableData: [],
            total: 0,
            dialogFormVisible: false,
            form: {},
            multipleSelection: [],
            categoryList: [],
            tagsArr: [],
            editor: null
        }
    },
    mounted() {
        this.findBySearch();
    },
    methods: {
        //查表
        findBySearch() {
            request.get("/blog/search", {
                params: this.params
            }).then(res => {
                if (res.code === '0') {
                    this.tableData = res.data.list;
                    this.total = res.data.total;
                    // console.log(this.tableData)
                } else {

                }
            })
            request.get("/category/findAll").then(res => {
                this.categoryList = res.data || []
                // console.log(this.categoryList)
            })
        },
        //重置查询
        reset() {
            this.params = {
                title: '',
            }
            this.params.pageSize = 5;
            this.findBySearch();
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
        //新增功能
        add() {
            this.form = {};
            this.tagsArr = []
            this.setRichText();
            this.dialogFormVisible = true;
        },
        //提交功能
        submit() {
            this.form.tags = JSON.stringify(this.tagsArr)
            this.form.content = this.editor.txt.html()
            // console.log(this.form)
            request.post("/blog/add", this.form).then(res => {
                if (res.code === '0') {
                    this.$message.success("操作成功");
                    this.dialogFormVisible = false;
                    this.findBySearch();
                } else {
                    this.$message.error(res.msg)
                }
            })
        },
        // 编辑功能
        edit(obj) {
            // console.log(obj)
            this.form = JSON.parse(JSON.stringify(obj));
            this.tagsArr = JSON.parse(this.form.tags) || [];
            this.dialogFormVisible = true;
            this.setRichText();
            setTimeout(() => {
                this.editor.txt.html(this.form.content)
            }, 0)
        },
        //删除功能
        del(id) {
            request.delete("/blog/delete/" + id).then(res => {
                if (res.code === '0') {
                    this.$message.success("删除成功");
                    this.findBySearch();
                } else {
                    this.$message.error(res.msg)
                }
            })
        },
        //批量删除
        delBatch() {
            if (this.multipleSelection.length === 0) {
                this.$message.warning("请勾选需要删除的项")
                return
            }
            request.put("/blog/delBatch", this.multipleSelection).then(res => {
                if (res.code === '0') {
                    this.$message.success("批量删除成功！")
                    this.findBySearch();
                } else {
                    this.$message.error(res.msg);
                }
            })
        },
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        getRowKeys(row) {
            return row.id;
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
        }
    }
}
</script>