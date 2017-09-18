{def $contacts = footer('footer_contacts')}
aaa
<ul class="social_widgets d_xs_none">
    <!--facebook-->
    {if is_set($contacts.facebook)}
	<li class="relative">
        <button class="sw_button t_align_c facebook"><i class="fa fa-facebook"></i></button>
        <div class="sw_content">
          <h3 class="color_dark m_bottom_20">Seguici su Facebook</h3>
          <iframe src="//www.facebook.com/plugins/likebox.php?href={$contacts.facebook|urlencode}&amp;width=235&amp;height=258&amp;colorscheme=light&amp;show_faces=true&amp;header=false&amp;stream=false&amp;show_border=false&amp;appId=287710204681096"
                  scrolling="no"
                  frameborder="0"
                  style="border:none; overflow:hidden; width:235px; height:258px;"
                  allowTransparency="true">
          </iframe>
        </div>
    </li>
	{/if}
    {if is_set($contacts.twitter)}
    <li class="relative">
        <button class="sw_button t_align_c twitter"><i class="fa fa-twitter"></i></button>
        <div class="sw_content">
            <h3 class="color_dark m_bottom_20">Ultimi Tweet</h3>
            <div class="twitterfeed m_bottom_25"></div>
            <a role="button" class="btn btn-lg btn-info" href="{$contacts.twitter}">Seguici su Twitter</a>
        </div>
    </li>
    {/if}    
    {if is_set($contacts.indirizzo)}
    <li class="relative">
        <button class="sw_button t_align_c googlemap"><i class="fa fa-map-marker"></i></button>
        <div class="sw_content">
            <h3 class="color_dark m_bottom_20">Dove siamo</h3>
            <div class="clearfix m_bottom_15">
              <i class="fa fa-map-marker f_left color_dark"></i>
              <p class="contact_e">{$contacts.indirizzo} </p>
              <iframe style="border:none; overflow:hidden; width:235px; height:258px;" class="r_corners full_width" id="gmap_mini" src="//maps.google.com/maps?q={$contacts.indirizzo|urlencode}&output=embed"></iframe>
            </div>
        </div>
    </li>
    {/if}
    <li class="relative">
        <button class="sw_button t_align_c contact"><i class="fa fa-rss"></i></button>
        <div class="sw_content">
            <h3 class="color_dark m_bottom_20">Per rimanere aggiornato</h3>
            <div class="clearfix m_bottom_15">
              <p>Per rimanere aggiornato su ciascun tema puoi gestire le tue iscrizioni alle newsletter tematiche quotidiane oppure utilizzare i feed RSS </p>
              <a role="button" class="btn btn-lg btn-info" href="{'notification/settings'|ezurl(no)}">Vai all'elenco RSS</a>
            </div>
        </div>
    </li>	
</ul>