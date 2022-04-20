define(["dojo/_base/declare",
        "dojo/_base/lang",
        "dojo/has",
        "../../../../base/Descriptor",
        "../../../../form/Element",
        "../../../../form/InputText",
        "../../../../form/iso/GcoElement",
        "dojo/text!./templates/MetadataLanguage.html",
        "../../../../../../kernel"],
function(declare, lang, has, Descriptor, Element, InputText, GcoElement, template, esriNS) {

  var oThisClass = declare(Descriptor, {

    templateString : template

  });

  if(has("extend-esri")) {
    lang.setObject("dijit.metadata.types.iso.gmd.metadataEntity.MetadataLanguage", oThisClass, esriNS);
  }

  return oThisClass;
});