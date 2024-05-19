<template>
    <div id="bar" style="width: 100%;height: 300px;"></div>
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
            userData: [],
            evaData: []
        }
    },
    mounted() {
        this.initEcharts()
    },
    methods: {
        getUserData() {
            const dataName = [], dataValue = [];
            let Xmax;
            request.get("/systemUser/echarts/bar").then(res => {
                if (res.code === '0') {
                    this.userData = res.data
                    Xmax = this.userData.length
                    // console.log(userData.length)
                    for (let i = 0; i < Xmax; ++i) {
                        dataName.push(this.userData[i].gender);
                        dataValue.push(this.userData[i].userNum)
                    }
                    // console.log(dataName)
                    // console.log(dataValue)
                    this.initBar(dataName, dataValue, Xmax - 1)
                    this.$emit('getAllUsers', parseInt(res.data[0].userNum) + parseInt(res.data[1].userNum))
                } else {
                    this.$message.error(res.msg);
                }
            })
        },
        getEvaData() {
            const dataName = [], dataValue = [];
            let Xmax;
            request.get("/blog/findAllBrand").then(res => {
                if (res.code === '0') {
                    this.evaData = res.data
                    Xmax = this.evaData.length
                    for (let i = 0; i < Xmax; ++i) {
                        dataName.push(this.evaData[i].categoryName);
                        dataValue.push(this.evaData[i].dayNum)
                    }
                    this.initBar(dataName, dataValue, Xmax - 1)
                }
            })
        },
        initEcharts() {
            if (this.temp === '0') {
                this.getUserData()
            }
            else {
                this.getEvaData()
            }

        },
        initBar(dataName, dataValue, Xmax) {
            let chartDom = document.getElementById('bar');
            let myChart = echarts.init(chartDom);
            let option;

            option = {
                xAxis: {
                    max: 'dataMax'
                },
                yAxis: {
                    type: 'category',
                    data: dataName,
                    inverse: true,
                    animationDuration: 300,
                    animationDurationUpdate: 300,
                    max: Xmax // only the largest 3 bars will be displayed
                },
                series: [
                    {
                        realtimeSort: true,
                        type: 'bar',
                        data: dataValue,
                        label: {
                            show: true,
                            position: 'right',
                            valueAnimation: true
                        }
                    }
                ],
                legend: {
                    show: true
                },
                animationDuration: 0,
                animationDurationUpdate: 3000,
                animationEasing: 'linear',
                animationEasingUpdate: 'linear'
            };
            function run() {
                myChart.setOption({
                    series: [
                        {
                            type: 'bar',
                            dataValue
                        }
                    ]
                });
            }
            setTimeout(function () {
                run();
            }, 0);
            setInterval(function () {
                run();
            }, 3000);

            option && myChart.setOption(option);
        }
    }
}
</script>