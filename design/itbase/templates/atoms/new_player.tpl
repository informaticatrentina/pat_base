{*
  $file - optional - the file to play (content of an attribute of type file)
  $url - optional - the url of the mp3 file (streaming)
  $items - array of nodes - optional - the items to play in case of a playlist
  $autoplay - true or false - wether the player should start automatically
*}
{if or($url,$items,$file)}

  {if $file}
    {def $url = concat("content/download/",$file.contentobject_id,"/",$file.content.contentobject_attribute_id,"/",$file.content.original_filename)|ezurl(no, full)}
  {/if}

  {def $swf_path= 'javascript/plugins/jquery.jplayer/jplayer'|ezdesign()}
  {ezscript_require( array( "ezjsc::jquery", "plugins/jquery.jplayer/jplayer/jquery.jplayer.min.js", "plugins/jquery.jplayer/add-on/jplayer.playlist.min.js" ) )}
  {ezcss_require( array( "plugins/jquery.jplayer/skin/blue.monday/css/jplayer.blue.monday.css" ) )}

  {if $url}
    <script type="text/javascript">
      //<![CDATA[
      $(document).ready(function(){ldelim}
        $("#vt_player_{$url|md5()}").jPlayer({ldelim}
          {literal}
          ready: function () {
            $(this).jPlayer("setMedia", {
                title: "",
                mp3: {/literal}"{$url}"{literal}
              }){/literal}{if $autoplay}.jPlayer('play'){/if}{literal};
          },
          cssSelectorAncestor: "#vt_container_{/literal}{$url|md5()}{literal}",
          swfPath: {/literal}{$swf_path}{literal},
          supplied: "mp3",
          wmode: "window",
          useStateClassSkin: true,
          autoBlur: false,
          smoothPlayBar: true,
          keyEnabled: true,
          remainingDuration: true,
          toggleDuration: true
        });
      });
      {/literal}
      //]]>
    </script>

    <div id="vt_player_{$url|md5()}" class="jp-jplayer"></div>
    <div id="vt_container_{$url|md5()}" class="jp-audio" role="application" aria-label="media player">
      <div class="jp-type-single">
        <div class="jp-gui jp-interface">
          <div class="jp-controls">
            <button class="jp-play" role="button" tabindex="0">play</button>
            <button class="jp-stop" role="button" tabindex="0">stop</button>
          </div>
          <div class="jp-progress">
            <div class="jp-seek-bar">
              <div class="jp-play-bar"></div>
            </div>
          </div>
          <div class="jp-volume-controls">
            <button class="jp-mute" role="button" tabindex="0">mute</button>
            <button class="jp-volume-max" role="button" tabindex="0">max volume</button>
            <div class="jp-volume-bar">
              <div class="jp-volume-bar-value"></div>
            </div>
          </div>
          <div class="jp-time-holder">
            <div class="jp-current-time" role="timer" aria-label="time">&nbsp;</div>
            <div class="jp-duration" role="timer" aria-label="duration">&nbsp;</div>
            <div class="jp-toggles">
              <button class="jp-repeat" role="button" tabindex="0">repeat</button>
            </div>
          </div>
        </div>
        <div class="jp-details">
          <div class="jp-title" aria-label="title">&nbsp;</div>
        </div>
        <div class="jp-no-solution">
          <span>Update Necessario</span>
          Per ascoltare è necesario aggiornare il tuo browser a una versione più recente, o aggiornare il tuo <a href="http://get.adobe.com/flashplayer/" target="_blank">plugin Flash</a>.
        </div>
      </div>
    </div>


  {elseif $items}
    <script type="text/javascript">
      //<![CDATA[
      $(document).ready(function(){ldelim}

        new jPlayerPlaylist({ldelim}
          jPlayer: "#vt_player_{$items[0].node_id}",
          cssSelectorAncestor: "#vt_container_{$items[0].node_id}"
        {rdelim}, [

          {foreach $items  as $item}
            {ldelim}
              title: "{$item.name|wash()}",
              {if $item.data_map.file.content.mime_type|eq('audio/mpeg')}
                  mp3: "{concat('/content/download/',$item.data_map.file.contentobject_id,'/',$item.data_map.file.content.contentobject_attribute_id,'/',$item.data_map.file.content.original_filename)}"
              {elseif $item.data_map.audio.content.mime_type|eq('audio/mpeg')}
                  mp3: "{concat('/content/download/',$item.data_map.audio.contentobject_id,'/',$item.data_map.audio.content.contentobject_attribute_id,'/',$item.data_map.audio.content.original_filename)}"
              {/if}
            {rdelim}
            {delimiter},{/delimiter}
          {/foreach}
        ],
         {literal}
         {
          swfPath: {/literal}{$swf_path}{literal},
          supplied: "mp3",
          wmode: "window",
          useStateClassSkin: true,
          autoBlur: false,
          smoothPlayBar: true,
          keyEnabled: true
        });
      });
      {/literal}
      //]]>
    </script>

<div id="vt_player_{$items[0].node_id}" class="jp-jplayer"></div>
<div id="vt_container_{$items[0].node_id}" class="jp-audio" role="application" aria-label="media player">
  <div class="jp-type-playlist">
    <div class="jp-gui jp-interface">
      <div class="jp-controls">
        <button class="jp-previous" role="button" tabindex="0">previous</button>
        <button class="jp-play" role="button" tabindex="0">play</button>
        <button class="jp-next" role="button" tabindex="0">next</button>
        <button class="jp-stop" role="button" tabindex="0">stop</button>
      </div>
      <div class="jp-progress">
        <div class="jp-seek-bar">
          <div class="jp-play-bar"></div>
        </div>
      </div>
      <div class="jp-volume-controls">
        <button class="jp-mute" role="button" tabindex="0">mute</button>
        <button class="jp-volume-max" role="button" tabindex="0">max volume</button>
        <div class="jp-volume-bar">
          <div class="jp-volume-bar-value"></div>
        </div>
      </div>
      <div class="jp-time-holder">
        <div class="jp-current-time" role="timer" aria-label="time">&nbsp;</div>
        <div class="jp-duration" role="timer" aria-label="duration">&nbsp;</div>
      </div>
      <div class="jp-toggles">
        <button class="jp-repeat" role="button" tabindex="0">repeat</button>
        <button class="jp-shuffle" role="button" tabindex="0">shuffle</button>
      </div>
    </div>
    <div class="jp-playlist">
      <ul>
        <li>&nbsp;</li>
      </ul>
    </div>
    <div class="jp-no-solution">
      <span>Update Necessario</span>
      Per ascoltare è necesario aggiornare il tuo browser a una versione più recente, o aggiornare il tuo <a href="http://get.adobe.com/flashplayer/" target="_blank">plugin Flash</a>.
    </div>
  </div>
</div>

{/if}
{/if}