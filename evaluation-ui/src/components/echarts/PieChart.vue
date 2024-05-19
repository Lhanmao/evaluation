<template>
    <div id="pie" style="width: 100%;height: 400px;"></div>
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
        getEvaNum() {
            request.get('/blog/findDayBrand').then(res => {
                if (res.code === '0') {
                    this.initBie(res.data)
                }
            })
        },
        getUserNum() {
            request.get("/systemUser/echarts/pie").then(res => {
                if (res.code === '0') {
                    this.initBie(res.data)
                    // console.log(res.data)
                } else {
                    this.$message.error(res.msg);
                }
            })
        },
        getTags() {
            request.get("/blog/findTags/" + '0').then(res => {
                if (res.code === '0') {
                    this.initBie(res.data)
                    // console.log(res.data)
                } else {
                    this.$message.error(res.msg);
                }
            })
        },
        initEcharts() {
            if (this.temp === '0') {
                this.getUserNum()
            }
            else if (this.temp === '1') {
                this.getEvaNum()
            }
            else {
                this.getTags()
            }

        },
        initBie(data) {
            let chartDom = document.getElementById('pie');
            let myChart = echarts.init(chartDom);
            let option;
            let textTile = ''
            if (this.temp === '0') {
                this.reUserDate(data);
                textTile = '男女增长比例'
            }
            else if (this.temp === '1') (
                textTile = '品牌测评增长比例'
                // this.reEvaData(data);
            )
            else {
                textTile = '鞋类测评比例'
            }


            option = {
                title: {
                    text: textTile,
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left'
                },
                series: [
                    {
                        name: '平台男女比例',
                        type: 'pie',
                        radius: '50%',
                        data: data,
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            option && myChart.setOption(option);
        },
        reUserDate(data) {
            for (let i = 0; i < data.length; i++) {
                if (data[i].name === '男') {
                    this.$emit('getBoys', data[i].value)
                }
                if (data[i].name === '女') {
                    this.$emit('getGirls', data[i].value)
                }
            }
        },
        reEvaData(data) {

        }
    }
}
</script>