define(["dojo/_base/declare",
        "dojo/_base/lang",
        "dojo/has",
        "esri/dijit/metadata/base/Descriptor",
        "esri/dijit/metadata/form/Element",
        "esri/dijit/metadata/form/InputDelimitedTextArea",
        "esri/dijit/metadata/form/iso/AbstractObject",
        "esri/dijit/metadata/form/iso/CodeListReference",
        "esri/dijit/metadata/form/iso/ObjectReference",
        "esri/dijit/metadata/types/iso/gmd/citation/SpecificationCitation",
        "esri/dijit/metadata/types/iso/gmd/identification/MD_KeywordTypeCode",
        "./MD_Concept",
        "./MD_KeywordClass",
        "dojo/text!./templates/MD_Keywords.html"],
function(declare, lang, has, Descriptor, Element, InputDelimitedTextArea, AbstractObject, CodeListReference,
  ObjectReference, SpecificationCitation, MD_KeywordTypeCode, MD_Concept, MD_KeywordClass, template) {

  var oThisClass = declare(Descriptor, {

    templateString : template

  });

  return oThisClass;
});
