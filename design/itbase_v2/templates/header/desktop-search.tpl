<div class="site-search">
    {if $pagedata.is_login_page|not()}
        <form action="{"/content/advancedsearch"|ezurl(no)}" id="topsearch">
            {if $pagedata.is_edit|not()}
                  <input type="text" name="SearchText" class="top-search-text" placeholder="{"FreeSearch"|i18n('design/pat_base/generic')}">
                  <input id="facet_field" name="facet_field" value="class" type="hidden" />
                  <input type="hidden" value="{"Search"|i18n('design/pat_base/generic')}" name="SearchButton" />
                  <button type="submit" name="SearchButton" class="btn btn-link" style="color: #fff; font-size: 1em"><i class="fa fa-search "></i> </button>
                  {if eq( $ui_context, 'browse' )}
                    <input name="Mode" type="hidden" value="browse" />
                  {/if}
            {/if}
        </form>
    {/if}
</div>