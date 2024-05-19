<template>
    <div>
        <div style="width: 100%;height: 100%;margin-top: 5%;">
            <div style="height: 50%;width: 50%;float: left;">
                <el-col :span="6" style="margin-left: 35%;">
                    <div>
                        <el-statistic group-separator="," :precision="2" :value="value1" title="今日增长人数">
                            <template slot="prefix">
                                <i class="el-icon-s-flag" style="color: red"></i>
                            </template>
                            <template slot="suffix">
                                <i class="el-icon-s-flag" style="color: blue"></i>
                            </template>
                        </el-statistic>
                    </div>
                </el-col>
                <div>
                    <LineChart @getValue="getValue" :temp="'0'"></LineChart>
                </div>
            </div>
            <div style="width: 50%;float: right;">
                <el-col :span="6" style="margin-top: 15%;float: right;">
                    <div>
                        <el-statistic title="男女比例">
                            <template slot="formatter">
                                {{ boy }}/{{ girl }}
                            </template>
                        </el-statistic>
                    </div>
                </el-col>
                <PieChart @getBoys="getBoys" @getGirls="getGirls" :temp="'0'"></PieChart>
            </div>
        </div>
        <div style="width: 100%;float: left;margin-top: 20px;">
            <h1 style="font-size: 20px;text-align: center;">平台男女总人数({{ allUser }}人)</h1>
            <BarChart @getAllUsers="getAllUsers" :temp="'0'"></BarChart>
        </div>
    </div>
</template>

<script>
import request from '@/utils/request';
import * as echarts from 'echarts';
import LineChart from '@/components/echarts/LineChart.vue'
import BarChart from '@/components/echarts/BarChart.vue'
import PieChart from '@/components/echarts/PieChart.vue'

export default {
    data() {
        return {
            value1: 0,
            boy: 0,
            girl: 0,
            allUser: 0
        }
    },
    components: {
        LineChart,
        BarChart,
        PieChart
    },
    methods: {
        getValue(value) {
            this.value1 = value
        },
        getAllUsers(allUser) {
            this.allUser = allUser
        },
        getBoys(num) {
            this.boy = num;
        },
        getGirls(num) {
            this.girl = num;
        }


    }
}
</script>
