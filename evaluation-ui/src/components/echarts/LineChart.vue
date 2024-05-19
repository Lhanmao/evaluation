<template>
    <div id="line" style="width: 100%;height: 300px;margin-top: 15%;">
    </div>
</template>
<script>
import request from '@/utils/request';
import * as echarts from 'echarts';

export default {
    props: {
        temp: ''
    },
    data() {
        return {
        }
    },
    mounted() {
        this.initEcharts();
    },
    methods: {
        getUserNum() {
            const createDate = [], newNum = [];
            request.get("/systemUser/echarts/line").then(res => {
                const UserData = res.data;
                if (res.code === '0') {
                    for (let i = 0; i < UserData.length; ++i) {
                        createDate[i] = UserData[i].create_date;
                        newNum[i] = UserData[i].newNum
                    }
                    // this.initLine(res.data)
                    this.initLine(createDate, newNum)
                } else {
                    this.$message.error(res.msg);
                }
            })
        },
        getEvaNum() {
            const createDate = [], newNum = [];
            request.get('/blog/findDayNum').then(res => {
                if (res.code === '0') {
                    const UserData = res.data;
                    if (res.code === '0') {
                        for (let i = 0; i < UserData.length; ++i) {
                            createDate[i] = UserData[i].newDate;
                            newNum[i] = UserData[i].dayNum
                        }
                        // this.initLine(res.data)
                        this.initLine(createDate, newNum)
                        // this.initLine(res.data)
                        // console.log(res.data)
                    }
                }
            })
        },
        initEcharts() {
            if (this.temp === '0') {//用户数据可视化
                this.getUserNum()
            }
            else {
                this.getEvaNum()
            }
        },
        initLine(createDate, newNum) {
            this.$emit('getValue', parseInt(newNum[0]))
            let chartDom = document.getElementById('line');
            let myChart = echarts.init(chartDom);
            let option;
            option = {
                xAxis: {
                    type: 'category',
                    data: createDate
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        data: newNum,
                        type: 'line'
                    }
                ]
            };
            option && myChart.setOption(option);
        },
    }
}
</script>
<style></style>