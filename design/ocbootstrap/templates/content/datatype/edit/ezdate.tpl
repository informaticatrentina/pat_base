{def $base = ezini('eZJSCore', 'LocalScriptBasePath', 'ezjscore.ini')}

{ezscript_require( 'ezjsc::yui2' )}
{ezcss_require( concat( '/', $base.yui2, 'calendar/assets/calendar.css' ) )}

<script type="text/javascript">
(function() {ldelim}
    YUILoader.addModule({ldelim}
        name: 'datepicker',
        type: 'js',
        fullpath: '{"javascript/ezdatepicker.js"|ezdesign( 'no' )}',
        requires: ["calendar"],
        after: ["calendar"],
        skinnable: false
    {rdelim});

    YUILoader.require(["datepicker"]);

    // Load the files using the insert() method.
    var options = [];
    YUILoader.insert(options, "js");
{rdelim})();
</script>

{default attribute_base='ContentObjectAttribute' html_class='full' placeholder=false()}
<div class="clearfix">
    {if $placeholder}<label>{$placeholder} {if $attribute.is_required}*{/if}</label>{/if}

{if ne( $attribute_base, 'ContentObjectAttribute' )}
    {def $id_base = concat( 'ezcoa-', $attribute_base, '-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
{else}
    {def $id_base = concat( 'ezcoa-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
{/if}

<div class="form-inline date">
    <input placeholder="{'Day'|i18n( 'design/admin/content/datatype' )}" id="{$id_base}_day" class="form-control" type="text" name="{$attribute_base}_date_day_{$attribute.id}" size="3" value="{section show=$attribute.content.is_valid}{$attribute.content.day}{/section}" />
    <input placeholder="{'Month'|i18n( 'design/admin/content/datatype' )}" id="{$id_base}_month"  class="form-control" type="text" name="{$attribute_base}_date_month_{$attribute.id}" size="3" value="{section show=$attribute.content.is_valid}{$attribute.content.month}{/section}" />
    <input placeholder="{'Year'|i18n( 'design/admin/content/datatype' )}" id="{$id_base}_year" class="year form-control" type="text" name="{$attribute_base}_date_year_{$attribute.id}" size="5" value="{section show=$attribute.content.is_valid}{$attribute.content.year}{/section}" />
    <span class="glyphicon glyphicon-calendar" id="{$attribute_base}_date_cal_{$attribute.id}" width="24" height="28" onclick="showDatePicker( '{$attribute_base}', '{$attribute.id}', 'date' );" style="cursor: pointer;"></span>
</div>

<div id="{$attribute_base}_date_cal_container_{$attribute.id}" style="display: none; position: absolute;"></div>




</div>
{/default}
