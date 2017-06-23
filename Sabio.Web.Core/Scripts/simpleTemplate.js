/* ********************************************************************************************
 * Author: Jim Speaker
 * Copyright 2012-2016, Jim Speaker
 * jim@iontech.org
 * Open-source licensed: https://github.com/jspeaker/simpleJsonTemplate/blob/master/license.txt
 * Documentation: https://github.com/jspeaker/simpleJsonTemplate/wiki
 * License: https://github.com/jspeaker/simpleJsonTemplate/blob/master/license.txt
* ****************************************************************************************** */
var simpleTemplate = (function () {
  var renderJson = function (url, data, target, selector, insertMode, resources, callback) {
    var template = templateCache.template(url), renderedContent;
    if (template != null) {
      selector && $(selector).remove();

      renderedContent = templateController.renderTemplate(template, data, resources);
      switch (insertMode) {
        case "append":
          $(target).append(renderedContent);
          break;
        case "insert":
          $(target).html(renderedContent);
          break;
        case "before":
          $(target).before(renderedContent);
          break;
        case "after":
          $(target).after(renderedContent);
          break;
        default:
          $(target).html(renderedContent);
          break;
      }

      if (callback)
        callback();
      return;
    }

    $.ajax({
      async: false,
      cache: true,
      dataType: "html",
      type: "GET",
      url: url,
      success: function (result) {
        templateCache.add(url, result);
        selector && $(selector).remove();

        renderedContent = templateController.renderTemplate(result, data, resources);
        switch (insertMode) {
          case "insert":
            $(target).html(renderedContent);
            break;
          case "before":
            $(target).before(renderedContent);
            break;
          case "after":
            $(target).after(renderedContent);
            break;
          default:
            $(target).html(renderedContent);
            break;
        }

        if (callback)
          callback();
      },
      error: function (xhr) {
        if (xhr.statusText !== "error") {
          templateCache.add(url, xhr.responseText);
          selector && $(selector).remove();

          switch (insertMode) {
            case "insert":
              $(target).html(templateController.renderTemplate(xhr.responseText, data));
              break;
            case "before":
              $(target).before(templateController.renderTemplate(xhr.responseText, data));
              break;
            case "after":
              $(target).after(templateController.renderTemplate(xhr.responseText, data));
              break;
            default:
              $(target).html(templateController.renderTemplate(xhr.responseText, data));
              break;
          }

          if (callback)
            callback();
          return;
        }
        $(target).html("Template " + url + " could not be loaded.");
      }
    });
  };

  return {
    renderJson: renderJson
  };
})();

var templateController = (function () {
  var propertyTypes = {
    encoded: {
      key: "encoded",
      pattern: "\\$(\\{)([^\\{])*(\\})",
      specifier: "$"
    },
    script: {
      key: "script",
      pattern: "\\!(\\{)([^\\{])*(\\})\\!",
      specifier: "!"
    }
  };

  var renderProperties = function (propertyType, element, data, itemName) {
    var pattern = propertyType.pattern,
      regEx = new RegExp(pattern, "g"),
      theHtml = element.outerHtml(),
      properties = theHtml.match(regEx),
      propertyNameIsolator,
      propertyName,
      propertyNames,
      value,
      index,
      length;

    if (properties == null) {
      element = $(theHtml);
      return element;
    }

    length = properties.length;
    for (index = 0; index < length; index += 1) {
      propertyNameIsolator = new RegExp(/[\$\{\}]/gi);
      propertyName = properties[index].replace(propertyNameIsolator, "").replace(itemName, "");
      try {
        propertyNames = propertyName.split(".");
        if (propertyNames.length === 1) { // handles property name from root
          value = data[propertyNames[0]];
        } else if (propertyNames.length === 2) { // handles object.property
          value = data[propertyNames[0]][propertyNames[1]];
        } else if (propertyNames.length === 3) { // handles object.object.property
          value = data[propertyNames[0]][propertyNames[1]][propertyNames[2]];
        } else if (propertyNames.length === 4) { // handles object.object.object.property
          value = data[propertyNames[0]][propertyNames[1]][propertyNames[2]][propertyNames[3]];
        } else {
          value = null;
        }
      } catch (ex) {
        value = null;
      }

      if (value !== undefined && value !== null) {
        var replaceRegex = new RegExp(properties[index].replace("$", "\\$").replace("{", "\\{").replace("}", "\\}").replace("[", "\\[").replace("]", "\\]"), "g");
        theHtml = theHtml.replace(replaceRegex, decodeURIComponent(value));
      }
    }

    element = $(theHtml);
    return element;
  };

  var renderScript = function (dom) {
    var regEx = new RegExp(propertyTypes.script.pattern, "g");
    var theHtml = dom.outerHtml();
    var scriptCalls = theHtml.match(regEx);
    if (scriptCalls == null) {
      dom = $(theHtml);
      return dom;
    }

    for (var i = 0; i < scriptCalls.length; i++) {
      var scriptCall = scriptCalls[i].replace("!{", "").replace("}!", "");
      var value;
      try {
        value = eval(scriptCall);
      } catch (ex) {
        value = null;
      }
      if (value === undefined || value === null) {
        value = "";
      }

      theHtml = theHtml.replace(scriptCalls[i], value);
    }

    dom = $(theHtml);
    return dom;
  };

  var evalInContext = function (code, context) {
    for (var varName in context) {
      if (context.hasOwnProperty(varName)) {
        var setContextVar = "var " + varName + " = context." + varName + ";\r\n";
        eval(setContextVar);
      }
    }

    try {
      return eval(code);
    } catch (error) {
      return false;
    }
  };

  var renderEncodedProperties = function (dom, data) {
    return renderProperties(propertyTypes.encoded, dom, data, "");
  };

  var cleanupItemConditions = function (dom) {
    var conditions = dom.find("*[data-if-item],*[if-item]");
    for (var i = 0; i < conditions.length; i++) {
      $(conditions[i]).removeAttr("data-if-item").removeAttr("if-item");
    }
  };

  var handleItemConditions = function (dom, data) {
    var conditions = dom.find("*[data-if-item],*[if-item]");
    for (var i = 0; i < conditions.length; i++) {
      var condition = $(conditions[i]).data("if-item");
      if (condition === undefined) {
        condition = $(conditions[i]).attr("if-item");
      }

      if (!evalInContext(condition, data)) {
        $(conditions[i]).remove();
      }
    }
    return dom;
  };

  var renderCollections = function (dom, data) {
    var collection = dom.find("*[data-foreach][data-in],*[foreach][in]"),
      counter1, counter2,
      element, collectionName, itemName,
      collectionData,
      step, pageSize, startIndex, lastIndex,
      newElement, parents;

    // filter out collections that are child collections of the current collection (nested)
    for (counter1 = 1; counter1 < collection.length; counter1 += 1) {
      parents = $(collection[counter1]).parents();
      for (counter2 = 0; counter2 < parents.length; counter2 += 1) {
        if ($(parents[counter2]).is($(collection[counter1 - 1]))) {
          collection.splice(counter1, 1);
        }
      }
    }

    if (collection.length === 0) {
      collection = dom.closest("[data-foreach][data-in],[foreach][in]");
    }

    for (counter1 = 0; counter1 < collection.length; counter1 += 1) {
      element = $(collection[counter1]);

      collectionName = element.data("in");
      if (collectionName === undefined) {
        collectionName = element.attr("in");
      }

      itemName = element.data("foreach");
      if (itemName === undefined) {
        itemName = element.attr("foreach");
      }

      step = element.data("step");
      if (step === undefined) {
        step = element.attr("step");
      }
      if (step === undefined) {
        step = 1;
      }

      collectionData = data[collectionName];

      if (collectionData !== undefined) {
        pageSize = element.data("pagesize");
        if (pageSize === undefined) {
          pageSize = element.attr("pagesize");
        }
        if (pageSize === undefined) {
          pageSize = collectionData.length;
        }

        if (data.Page === undefined || data.Page === null) {
          data.Page = 1;
        }

        startIndex = (pageSize !== collectionData.length ? data.Page * pageSize : pageSize) - pageSize;
        lastIndex = pageSize < collectionData.length ? (pageSize * data.Page) - 1 : collectionData.length - 1;
        if (lastIndex > collectionData.length - 1) {
          lastIndex = collectionData.length - 1;
        }

        for (counter2 = startIndex; counter2 <= lastIndex; counter2 = counter2 + step) {
          newElement = element.clone();
          handleItemConditions(newElement, collectionData[counter2]);
          newElement.removeAttr("data-foreach").removeAttr("data-in").removeAttr("foreach").removeAttr("in");
          newElement = renderProperties(propertyTypes.encoded, newElement, collectionData[counter2], itemName + ".");
          newElement = renderCollections(newElement, collectionData[counter2]);
          element.parent().append(newElement);
        }
        cleanupItemConditions(element.parent());
        element.remove();
      }
    }
    return dom;
  };

  var handleConditions = function (dom, data) {
    var conditions = dom.find("*[data-if],*[if]"), i, condition;
    for (i = 0; i < conditions.length; i += 1) {
      condition = $(conditions[i]).data("if");
      if (condition === undefined) {
        condition = $(conditions[i]).attr("if");
      }

      if (!evalInContext(condition, data)) {
        $(conditions[i]).remove();
      }
      $(conditions[i]).removeAttr("data-if").removeAttr("if");
    }
    return dom;
  };

  var replaceResourceTokens = function(dom, resources) {
    // find all unique tokens
    var resourcedElements = dom.find("*[data-resource],*[resource]"), i, resourceToken;
    for (i = 0; i < resourcedElements.length; i += 1) {
      resourceToken = $(resourcedElements[i]).data("resource");
      if (resourceToken === undefined) {
        resourceToken = $(resourceToken).attr("resource");
      }

      if (resourceToken) {
        try {
          var resource = resources[resourceToken];
          $(resourcedElements[i]).text(resource);
        } catch (e) { }
      }
    }
    return dom;
  };

  var renderTemplate = function (template, data, resources) {
    // prevent template from firing potential 404s by attempting to load resources when initially added to dom
    template = template.replace(/ src\=/gi, " src_temp_disabled=");

    var dom = $(template);
    dom = handleConditions(dom, data);
    dom = renderEncodedProperties(dom, data);
    dom = renderCollections(dom, data);
    if (resources) {
      dom = replaceResourceTokens(dom, resources);
    }

    dom = renderScript(dom, data);

    dom = $(dom.outerHtml().replace(/src_temp_disabled\=/gi, " src="));
    return dom.outerHtml();
  };

  return {
    renderTemplate: renderTemplate
  };
})();

var conditionManager = (function () {
  var parse = function (condition) {
    return condition.replace(/\#/g, "data.");
  };

  return {
    parse: function (condition) {
      return parse(condition);
    }
  };
})();

var templateCache = (function () {
  var cache = [];

  var clear = function () {
    cache = [];
  };

  var add = function (key, value) {
    cache.push({ key: key, value: value });
  };

  var template = function (key) {
    for (var i = 0; i < cache.length; i++) {
      if (cache[i].key === key)
        return cache[i].value;
    }
    return null;
  };

  var exists = function (key) {
    for (var i = 0; i < cache.length; i++) {
      if (cache[i].key === key)
        return true;
    }
    return false;
  };

  return {
    add: function (key, value) {
      if (!exists(key))
        return add(key, value);
      return false;
    },
    template: function (key) {
      return template(key);
    },
    count: function () {
      return cache.length;
    },
    clear: function () {
      clear();
    }
  };
})();
