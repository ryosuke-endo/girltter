import Vue from 'vue/dist/vue'
import Vuex from 'vuex/dist/vuex'
import axios from 'axios/dist/axios'
import URI from 'urijs'

Vue.use(Vuex)

const state = {
  count: {},
  visiable: false
}

const mutations = {
  setCount(state, count) {
    state.count = count
  },
  canVisiable(state) {
    state.visiable = true
  }
}

const actions = {
  canVisiable({commit}) {
    commit('canVisiable')
  },
  fetchCount({commit}) {
    return new Promise((resolve, reject) => {
      const path = URI(location.href).path()
      const url = `${path}/count_map`
      axios({
        method: "get",
        url: url
      })
      .then(function(res){
        commit('setCount', res.data)
        resolve()
      })
      .catch(function(error) {
        console.log("action fail")
      })
    })
  }
}

export default new Vuex.Store({
  state,
  actions,
  mutations
})
