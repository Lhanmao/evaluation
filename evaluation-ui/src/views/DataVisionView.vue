<template>
    <div style="background-color: #f2f3f5;">
        <div style="margin-bottom: 1%;">
            <TopBar :activeIndex="'/dataVision'"></TopBar>
        </div>
        <div>
            <div style="display: flex;padding-left: 20%;">
                <div style="display: flex;flex-direction: column;gap: 20px;">
                    <div class="card" style="width: 650px;padding: 10px;">
                        <div style="display: flex;gap: 30px;padding: 5px;font-size: 17px;margin-left: 120px;">
                            <div class="tool-bar" :class="{ 'tool-bar-active': item.name === currBar }"
                                v-for="item in barList" :key="item.id" @click="clickBar(item.name)">
                                {{ item.name }}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div style="display: flex;margin-top: 5%;gap: 1%;" v-if="barName === '近日测评量'">
            <div style="width: 50%;height: 500px;">
                <el-col :span="6" style="margin-left: 35%;">
                    <div style="margin-bottom: 10px;">
                        <el-statistic group-separator="," :precision="2" :value="value1" title="今日测评增长">
                            <template slot="prefix">
                                <i class="el-icon-s-flag" style="color: red"></i>
                            </template>
                            <template slot="suffix">
                                <i class="el-icon-s-flag" style="color: blue"></i>
                            </template>
                        </el-statistic>
                    </div>
                </el-col>
                <LineChart @getValue="getValue" :temp="'1'" style="margin-top: 6%;"></LineChart>
            </div>
            <div style="width: 50%;height: 500px;">
                <PieChart :temp="'1'"></PieChart>
            </div>
        </div>
        <div style="display: flex;margin-top: 5%;gap: 1%;" v-else-if="barName === '鞋类测评比例'">
            <div style="width: 50%;height: 500px;padding-left: 20px;">
                <PieChart :temp="'2'"></PieChart>
            </div>
            <div style="width: 50%;height: 500px;padding-left: 10%;">
                <VerticalChart></VerticalChart>
            </div>
        </div>
        <div style="display: flex;margin-top: 3%;gap: 1%;padding-bottom: 80px;" v-else>
            <div style="width: 100%;height: 500px;">
                <BarChart :temp="'1'" style="height: 450px;"></BarChart>
            </div>
        </div>
    </div>
</template>
<script>
import request from '@/utils/request';
import TopBar from '../components/TopBarView.vue'
import LineChart from '@/components/echarts/LineChart.vue'
import PieChart from '@/components/echarts/PieChart.vue'
import BarChart from '@/components/echarts/BarChart.vue'
import VerticalChart from '@/components/echarts/VerticalChart.vue'

export default {
    data() {
        return {
            barList: [{ name: '近日测评量' }, { name: '鞋类测评比例' }, { name: '品牌测评量' }],
            currBar: '近日测评量',
            value1: '',
            barName: '近日测评量'
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
    components: {
        TopBar,
        LineChart,
        PieChart,
        BarChart,
        VerticalChart
    },
    methods: {
        getValue(value) {
            this.value1 = value
        },
        clickBar(currBar) {
            this.barName = currBar
            this.currBar = currBar
        }
    }
}
</script>
<style scoped>
.tool-bar {
    font-size: 17px;
    cursor: pointer;
    padding: 4px;
}

.tool-bar-active {
    background-color: #1890ff;
    color: #fff;
    border-radius: 5px;
}
</style>