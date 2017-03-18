import Vue from 'vue/dist/vue'
import Vuex from 'vuex/dist/vuex'
import axios from 'axios/dist/axios'
import URI from 'urijs'

Vue.use(Vuex)

const state = {
  icons: {},
  visiable: false
}

const mutations = {
  setIcons(state, icons) {
    state.icons = icons
  },
  canVisiable(state) {
    state.visiable = true
  },
  createReaction(state, res) {
    const reactionable = res.type === "Topic" ?
      state.icons.topic : state.icons.comment[res.reactionable_id]
    if(reactionable === undefined) {
      reactionable[res.icon.id] = []
    }

    if(reactionable[res.icon.id] !== undefined) {
      reactionable[res.icon.id].push(res.icon)
    } else {
      reactionable[res.icon.id] = [res.icon]
    }

    if(reactionable.user_reactioned_ids !== undefined) {
      reactionable.user_reactioned_ids.push(res.icon.id)
    } else {
      reactionable.user_reactioned_ids = [res.icon.id]
    }
  },
  destroyReaction(state, res) {
    const reactionable = res.type === "Topic" ?
      state.icons.topic : state.icons.comment[res.reactionable_id]
    reactionable[res.icon.id].shift()
    const index = reactionable.user_reactioned_ids.indexOf(res.icon.id)
    reactionable.user_reactioned_ids.splice(index, 1)
  }
}

const actions = {
  canVisiable({commit}) {
    commit('canVisiable')
  },
  createReaction({commit}, res) {
    commit('createReaction', res)
  },
  destroyReaction({commit}, res) {
    commit('destroyReaction', res)
  },
  fetchReaction({commit}) {
    return new Promise((resolve, reject) => {
      const path = URI(location.href).path()
      const url = `${path}/reaction_count_map`
      axios({
        method: "get",
        url: url
      })
      .then(function(res){
        commit('setIcons', res.data)
        resolve()
      })
      .catch(function(error) {
        console.log("fetchReaction fail")
      })
    })
  }
}

export default new Vuex.Store({
  state,
  actions,
  mutations
})
