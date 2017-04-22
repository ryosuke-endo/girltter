export default class {
  static send(category, label) {
    ga('send','event',category,'Click',label)
  }
}
