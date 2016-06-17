<form id="site-wide-search" role="form" class="form" method="get" action="{'/content/search'|ezurl( 'no' )}">
    <div class="form-group">
        <div class="input-group">
            <div class="input-group-addon">
                <i class="fa fa-search"></i>
            </div>
                
            {if $pagedata.is_edit}
                <input class="form-control" 
                       type="search" 
                       name="SearchText" 
                       id="site-wide-search-field" 
                       placeholder="{'Search'|i18n('design/ocbootstrap/pagelayout')}" 
                       disabled="disabled" />
            {else}
                <input class="form-control" 
                       type="search" 
                       name="SearchText" 
                       id="site-wide-search-field" 
                       placeholder="{'Search'|i18n('design/ocbootstrap/pagelayout')}" />
                {if eq( $ui_context, 'browse' )}
                    <input name="Mode" type="hidden" value="browse" />
                {/if}
            {/if}
        </div>
    </div>
</form>
