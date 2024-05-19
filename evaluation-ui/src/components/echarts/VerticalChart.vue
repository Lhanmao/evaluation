<template>
    <div id="vertical" style="width: 80%;height: 400px;"></div>
</template>
<script>
import request from '@/utils/request';
import * as echarts from 'echarts';

export default {
    data() {
        return {
            evaData: []
        }
    },
    mounted() {
        this.initEcharts();
        // this.getEvaNum()
    },
    methods: {
        getEvaChart() {
            const dataName = [], dataValue = [];
            let Xmax
            request.get("/blog/findTags/" + '1').then(res => {
                if (res.code === '0') {
                    this.evaData = res.data
                    Xmax = this.evaData.length
                    for (let i = 0; i < Xmax; ++i) {
                        dataName.push(this.evaData[i].name);
                        dataValue.push(this.evaData[i].value)
                    }
                    this.initVertical(dataName, dataValue)
                }
            })
        },
        initEcharts() {
            this.getEvaChart();
        },
        initVertical(dataName, dataValue) {
            let chartDom = document.getElementById('vertical');
            let myChart = echarts.init(chartDom);
            let option;
            option = {
                title: {
                    text: "鞋类热度",
                    left: 'center'
                },
                xAxis: {
                    type: 'category',
                    data: dataName
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        data: dataValue,
                        type: 'bar'
                    }
                ]
            };
            option && myChart.setOption(option);

        }
    }
}
</script>