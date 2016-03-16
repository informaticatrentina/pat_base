{if and( is_set( $url ), $url|ne('') )}
<div id="footer_sensor" style="cursor: pointer;position:fixed;bottom:0px;max-height:100px;width:100%;box-shadow: 0 -3px 5px #888888; background-image: url('{'sensor_banner/bg.png'|ezimage(no)}');z-index:999999;" onclick="window.location = '{$url}';">
  <div style="height: 79px;position: absolute;right: 0;top: 0;width: 20%;background-image:url('{'sensor_banner/bg_dark.png'|ezimage(no)}')"></div>
    <div class="container">
        <div class="row">
            <div class="col-sm-3 text-center hidden-xs">
                <img class="img-responsive" style="position: relative;top: -19px;" src="{'sensor_banner/logo.png'|ezimage(no)}"/>
            </div>
            <div class="col-xs-9 col-sm-6 text-center">
                <img class="img-responsive" style="margin-top: 10px" src="{'sensor_banner/opinione.png'|ezimage(no)}" />
            </div>
            <div class="col-xs-3" style="padding-left: 0;background-image: url('{'sensor_banner/bg_dark.png'|ezimage(no)}');">
                <a href="{$url}" class="clearfix" style="text-align:right;display:block;background-repeat:no-repeat;background-image:url('{'sensor_banner/a_bg.png'|ezimage(no)}')">
                    <img class="img-responsive pull-right" src='{'sensor_banner/partecipa.png'|ezimage(no)}' alt="Partecipa"/>
                </a>
            </div>
        </div>
    </div>
</div>
<style>#go_to_top{ldelim}z-index: 3000;top: 60%;left: 44%;{rdelim}</style>
{/if}