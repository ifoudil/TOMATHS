
const app = Vue.createApp({
    data () {
        return{
            keyboardControl : false,
        };
    },


    methods : {
        showUpgrades(){
            this.keyboardControl = !this.keyboardControl;
            console.log("show")
        },
    }
})
app.mount('#app');
