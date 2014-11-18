/**
 * @author Daniel Boorn, daniel.boorn@gmail.com
 * @license CC BY-NC 4.0, http://creativecommons.org/licenses/by-nc/4.0/
 * @type {exports}
 */
var exec = require('cordova/exec');

var liliSwipe = {
    start: function (resultHandler, errorHandler) {
        exec(function (result) {
            imag.start(resultHandler, errorHandler);
            resultHandler(result);
        }, function (result) {
            imag.start(resultHandler, errorHandler);
            errorHandler(result);
        }, "LiLiSwipePlugin", "registerListener", []);
    },
    isConnected: function (resultHandler, errorHandler) {
        exec(resultHandler, errorHandler, "LiLiSwipePlugin", "isConnected", []);
    }
};

module.exports = liliSwipe;