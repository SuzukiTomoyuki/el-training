$(document).on('turbolinks:load', function(){
    enchant();
    window.onload = function () {
        var game = new Game(480, 270);
        game.onload = function () {
            var label = new enchant.Label();
            label.text = "Hello, enchant.js!";
            label.width = 256;
            label.height = 64;
            label.font = "24px 'Arial'";
            game.rootScene.addChild(label);
        };
        game.start();
    }
});