$(document).on('turbolinks:load', function(){
    // var sW,sH,s;
	// sW = window.innerWidth;
    // sH = window.innerHeight;
    // window.resizeTo(sW, sH);
    enchant();

    window.onload = function(){
        //背景素材
        var back_win_url ='/assets/images/system/haikei.jpg';
        //枠素材
        var mess_win_url ='/assets/images/system/hukidashi.png';

        //基本設定
        var game = new Core(960,540);
        game.fps = 20;
        game.preload(mess_win_url, back_win_url);





        //本体
        game.onload = function(){
            //　背景
            var haikei = new Sprite(800, 600);
            haikei.image = game.assets[back_win_url];
            haikei.x = 70
            game.rootScene.addChild(haikei);
            // //セリフ枠作成
            var window = new Sprite(508,215);
            window.image = game.assets[mess_win_url];
            window.x = 200;
            window.y = -20;
            window.scaleY = 0.8;
            window.scaleX = 0.9;
            game.rootScene.addChild(window);

            // novel.enchant.js のインスタンス生成.
            // var novel = new Novel( 160, 380, 620, 100 );
            var novel = new Novel(  240, 0, 420, 100 );
            // novel.x = 160;
            // novel.y = 380;
            novel.setFontSize( 24 );
            novel.setLineHeight( 20 );
            novel.setPadding( 15, 12, 12, 12 );
            novel.setFontFamily( "PixelMplus12" );
            // novel.x = 160;
            // novel.y = 380;
            game.rootScene.addChild( novel );
            


            game.selectChoice = function( id, select ) {
                switch ( id ) {
                    case 1:
                        switch ( select ) {
                            case 1:
                                novel.setText( "数多の惑星だってそうだ。" );
                                novel.setText( "地球も、地球の一生物に過ぎない人間も、そして僕も、意味があって存在している。" );
                                novel.setText( "何かを成す為に。" );
                                novel.setText( "（タッチで効果音「チャイム」を鳴動）" );
                                // novel.setSE( SND_CHIME, 3000 );
                                novel.setText( "（鳴り終わりを待って次の文を表示）" );
                                break;
                            case 2:
                                novel.setText( "その惑星に生息する生物だってそうだ。" );
                                novel.setText( "地球も、地球の一生物に過ぎない人間も、そして僕も、意味があって存在している。" );
                                novel.setText( "何かを成す為に。" );
                                novel.setText( "（タッチで効果音「電話」を鳴動）" );
                                // novel.setSE( SND_PHONE, 0 );
                                novel.setText( "（鳴り終わりを待たずに次の文を表示）" );
                                break;
                            default:
                                break;
                        }
                        break;
                    default:
                        break;
                }
            };
            novel.setText( "僕はどこからどう見ても、紛れも無く人間だが、同時に、地球という惑星の、一生物に過ぎない。" );
            novel.setText( "宇宙は何の意味もなく、ただ生まれただけなのだろうか、いや、僕はそうは思わない。" );
            novel.setText( "宇宙は、”何か”によって求められて、何かを成す為に生まれてきたんだ。" );
            novel.setPageBreak();
            novel.setChoice( 1,
                "数多の惑星だってそうだ。",
                "その惑星に生息する生物だってそうだ。",
                "",
                "",
                game.selectChoice );

            // 画面タッチで次へ.
            game.rootScene.ontouchstart = function() {
                novel.next();
            }


            // //クラス
            // var novel = function(text,main_scene){
            //
            //     var zisuu = text.length;
            //
            //
            //
            //     //ラベルを作る
            //     var novel_on = new Label();
            //     novel_on.x = 175;
            //     novel_on.y = 380;
            //     novel_on.width = 405;
            //     novel_on.height = 160;
            //     novel_on.color = '#000000';
            //     novel_on.font = "24px ＭＳゴシックＰ";
            //
            //     //一時停止用シーン
            //     var pause_scene_at = new Scene();//＠
            //     var pause_scene_and = new Scene();//＆
            //     var pause_scene_end = new Scene();//＄
            //
            //     //フレームに併せて一文字ずつ表示していく
            //     var str = 0;
            //     novel_on.on('enterframe',function(){
            //
            //
            //         //記号取得用
            //         var key = text.substring(str,str+1);
            //
            //         //フレームにあわせて一文字ずつ表示していく
            //         novel_on.text = text.substring(0,str);
            //
            //
            //         //各記号で動作を制御
            //         if(key == "@"){//クリック待ち
            //
            //             //@を取り除く
            //             text = text.replace( "@" , "" );
            //
            //             zisuu = text.length;
            //
            //             //フレームを止める
            //             game.pushScene(pause_scene_at);
            //
            //             //クリックでフレーム再開
            //             pause_scene_at.on('touchend',function(){
            //
            //
            //                 //ポーズシーンを排除・再動作
            //                 game.popScene(pause_scene_at);
            //                 game.pushScene(main_scene);
            //
            //
            //             });
            //
            //
            //
            //         }else if(key == "%"){//改行+クリック待ち
            //
            //
            //             // %を改行に置き換え
            //             text = text.replace( "%" , "<br/>" );
            //             str += 5;
            //
            //             zisuu = text.length;
            //
            //             //フレームを止める
            //             game.pushScene(pause_scene_at);
            //
            //             //クリックでフレーム再開
            //             pause_scene_at.on('touchend',function(){
            //
            //
            //                 //ポーズシーンを排除・再動作
            //                 game.popScene(pause_scene_at);
            //                 game.pushScene(main_scene);
            //
            //
            //             });
            //
            //
            //
            //
            //
            //
            //         }else if(key == "&"){//改ページ
            //
            //
            //             //&を取り除く
            //             text = text.replace( "&" , "" );
            //             zisuu = text.length;
            //
            //             //フレームを止める
            //             game.pushScene(pause_scene_and);
            //
            //             //クリックでフレーム再開
            //             pause_scene_and.on('touchend',function(){
            //
            //
            //                 //ポーズシーンを排除・再動作
            //                 game.popScene(pause_scene_and);
            //                 game.pushScene(main_scene);
            //
            //                 //残っているテキストを抽出
            //                 text = text.slice(str,zisuu);
            //
            //
            //                 //フレーム進行をリセット
            //                 str = 0;
            //
            //             });
            //
            //
            //
            //         }else if(key == "$"){//文章終わり
            //
            //             //フェードアウト
            //             novel_on.tl.delay(20).fadeOut(20).then(function(){
            //
            //                 //削除
            //                 main_scene.removeChild(novel_on);
            //             });
            //
            //
            //         }else{//通常の表示
            //
            //             str++;
            //
            //         }
            //
            //
            //     });
            //
            //
            //
            //
            //
            //     //表示
            //     main_scene.addChild(novel_on);
            //
            //
            //
            // }
            //
            //
            //
            //
            //
            //
            //
            //
            // //メインシーンを作成
            // var n_scene = new Scene();
            //
            //
            // // //とりあえずラベル作成
            // // var label = new Label("テスト");
            // // label.x = 300;
            // // label.y = 270;
            // // label.color = '#000000';
            // // label.font = "20px cursive";
            // //
            // // //適当にイベント設定
            // // label.on('touchstart', function(){
            // //     alert("test");
            // // });
            // //
            // //
            // // //文字を表示
            // // n_scene.addChild(label);
            //
            // //セリフ枠作成
            // var window = new Sprite(640,190);
            // window.image = game.assets[mess_win_url];
            // window.x = 150;
            // window.y = 350;
            //
            // //台詞枠表示
            // n_scene.addChild(window);
            //
            // //メインシーン表示
            // game.pushScene(n_scene);
            //
            //
            //
            //
            //
            //
            // //テキスト
            // var text = "クリック待ちです。@改行+クリック待ちをしています。%改行しました。@改ページします。&ぎおんしょうじゃのかねのこえ@しょぎょうむじょうのひびきあり&しゃらそうじゅのはなのいろ%じょうしゃひっすいのことわりをあらわす&おごれるひともひさしからず%ただはるのよのゆめのごとし@たけきものもついにはほろびぬ@ひとえにかぜのまえのちりにおなじ$";
            //
            // //ノベル部分を表示
            // novel(text,n_scene);


        };


        game.start();

    };
});