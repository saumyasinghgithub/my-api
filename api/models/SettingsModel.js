const BaseModel = require("./BaseModel");

class SettingsModel extends BaseModel {
  table = "settings";
  pageLimit = 10;

  siteData(siteData) {
    console.log(siteData.id);
    let sql = `SELECT users.firstname, users.middlename, users.lastname, settings.* FROM settings INNER JOIN users ON settings.trainer_id = users.id WHERE settings.trainer_id = ? `
    return this.db.run(sql,[siteData.id]);
  }

}

module.exports = SettingsModel;
