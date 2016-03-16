<div class="site-menu nav-main navbar" id="navigation">
  {if $pagedata.is_login_page|not()}
  <div class="clearfix">
    <!--button for responsive menu-->
    
    <div class="navbar-header hidden-md hidden-lg">
        <button id="menu_button" class="navbar-toggle">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
    </div>
    

    <!--main menu-->
    {include uri=concat('design:menu/top_menu.tpl')}
  </div>
  {/if}
</div>