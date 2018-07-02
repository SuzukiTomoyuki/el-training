$(document).on('turbolinks:load', function(){
    enchant();

    window.onload = function(){
        //背景素材
        var back_win_url ='/assets/images/system/haikei.jpg';
        //枠素材
        var mess_win_url ='/assets/images/system/hukidashi.png';
        // ayame
        var ayame_url = "/assets/images/system/sd_ayame_sprite.png";

        //基本設定
        var game = new Core(960,540);
        game.fps = 20;
        game.preload(mess_win_url, back_win_url, ayame_url);

        Ayame = Class.create(Sprite, {
           initialize:function(){
               // var ayame = new Sprite(304, 469);
               Sprite.call(this, 304, 469);
               this.image = game.assets[ayame_url];
               this.x = 300;
               this.y = 180;
               this.scaleX = this.scaleY = 1.2;
               this.frame = 0;
               game.rootScene.addChild(this);
           },
            updateFrame:function(param){
                game.rootScene.addEventListener('touchstart', function(event) {
                    this.frame = param;
                });
            }
        });

        //本体
        game.onload = function(){
            //　背景
            var haikei = new Sprite(800, 600);
            haikei.image = game.assets[back_win_url];
            haikei.x = 70;
            game.rootScene.addChild(haikei);
            // ayame
            ayame = new Ayame();
            // //セリフ枠作成
            var window = new Sprite(508,215);
            window.image = game.assets[mess_win_url];
            window.x = 200;
            window.y = -20;
            window.scaleY = 0.8;
            window.scaleX = 0.9;
            game.rootScene.addChild(window);

            // novel.enchant.js のインスタンス生成.
            var novel = new Novel(  240, 0, 420, 100 );
            novel.setFontSize( 24 );
            novel.setLineHeight( 20 );
            novel.setPadding( 15, 12, 12, 12 );
            novel.setFontFamily( "PixelMplus12" );
            game.rootScene.addChild( novel );

            game.selectChoice = function( id, select ) {
                switch ( id ) {
                    case 1:
                        switch ( select ) {
                            case 1:
                                ayame.frame = 2;
                                break;
                            case 2:
                                ayame.frame = 2;
                                break;
                            default:
                                break;
                        }
                        break;
                    default:
                        break;
                }
            };
            game.selectChoice2 = function( id, select ) {
                switch ( id ) {
                    case 1:
                        switch ( select ) {
                            case 1:
                                ayame.frame = 1;
                                break;
                            case 2:
                                ayame.frame = 1;
                                break;
                            default:
                                break;
                        }
                        break;
                    default:
                        break;
                }
            };
            var responceData;
            $.ajax({
                url: '/users/' + $('.enchant-ayame').attr('data-user') + '/check_oko.json',
                type: 'GET',
                dataType: 'json',
                cache: false,
                async: false,
                success: function( data ) {
                    console.log(data);
                    responceData = data;
                }
            });
            // $('.enchant-ayame').attr('oko', true);
            console.log(responceData.oko);
            if (responceData.oko){
                novel.setText( "ようし、そこに直れ！" );
                var checkFirstEvent = true;
                game.rootScene.addEventListener('touchstart', function(event) {
                    ayame.tl.moveTo(300, 200, 2);
                    if (checkFirstEvent) ayame.frame = 1;
                    ayame.tl.moveTo(300, 180, 2);
                    checkFirstEvent = false;
                });
                novel.setPageBreak();
                novel.setText( "妾が言いたいことはわかるな？" );
                novel.setPageBreak();
                novel.setText( "わかるじゃろ？" );
                novel.setPageBreak();
                novel.setText("ん？");
                novel.setPageBreak();
                novel.setText("なんか言いたいことはあるか？");
                novel.setPageBreak();
                novel.setChoice( 1,
                    "言い訳しない。",
                    "言い訳させない。",
                    "",
                    "",
                    game.selectChoice );
                novel.setPageBreak();
                novel.setText("阿呆が。");
                novel.setText("お主に言い訳などさせんわ。");
                novel.setPageBreak();
                novel.setText( "言い訳したり人に迷惑かけたりするのは" );
                novel.setText("あれじゃぞ？");
                novel.setText("最低じゃぞ？");
                novel.setPageBreak();
                novel.setText( "もちろん妾もあんまり好かん。" );
                novel.setText( "普段の態度露骨に変えるぞ。" );
                novel.setPageBreak();
                novel.setChoice( 1,
                    "わかった",
                    "はい",
                    "",
                    "",
                    game.selectChoice2 );
                novel.setPageBreak();
                novel.setText("うむ、良い子じゃ！");
                novel.setPageBreak();
                novel.setText("ほれ、");
                novel.setText("わかったらとっとと此処から往ね");
                novel.setPageBreak();
                novel.setText("もうこっちに戻って来るで無いぞ〜");
                novel.setPageBreak();
            } else{
                novel.setText("......");
                novel.setText("およ？");
                novel.setPageBreak();
                var checkFirstEvent = true;
                game.rootScene.addEventListener('touchstart', function(event) {
                    ayame.tl.moveTo(300, 200, 2);
                    if (checkFirstEvent) ayame.frame = 1;
                    ayame.tl.moveTo(300, 180, 2);
                    checkFirstEvent = false;
                });
                novel.setText("妾に会いに来たのか？");
                novel.setPageBreak();
                novel.setText("歓迎するぞ！！");
                novel.setText("と言いたいところじゃが");
                novel.setPageBreak();
                novel.setChoice( 1, "？", "", "", "", game.selectChoice);
                novel.setPageBreak();
                novel.setText("此処は説教部屋であるが故");
                novel.setText("お主のようなものが来る所では無い。");
                novel.setPageBreak();
                novel.setChoice( 1, "...", "", "", "", game.selectChoice2);
                novel.setPageBreak();
                novel.setText("ふむ、わかったならそれで良い");
                novel.setPageBreak();
                novel.setText("さっさと往ね");
            }


            // 画面タッチで次へ.
            game.rootScene.ontouchstart = function() {
                try {
                    novel.next();
                } catch ( e ){
                    // console.log($('.enchant-ayame').attr('data-user'));
                    console.log(Boolean($('.enchant-ayame').attr('data-oko')));
                    ayame.tl.fadeOut(20);
                    haikei.tl.fadeOut(20);
                    window.tl.fadeOut(20);
                    setTimeout( function() {
                        $.ajax({
                            url: '/users/done_osekkyo/' + $('.enchant-ayame').attr('data-user'),
                            type: 'PATCH'
                        })
                    }, 1500);

                }
            }
        };
        game.start();

    };
});
