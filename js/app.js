// Generated by CoffeeScript 1.9.0
var FormHelper, IStorage, QList, QLocalStorage, QManager, QRelation, QValidation,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

(function() {
  this.uniqid = function(pr, en) {
    var result, us;
    pr = pr || "";
    en = en || false;
    result = void 0;
    us = void 0;
    this.seed = function(s, w) {
      s = parseInt(s, 10).toString(16);
      if (w < s.length) {
        return s.slice(s.length - w);
      } else {
        if (w > s.length) {
          return new Array(1 + (w - s.length)).join("0") + s;
        } else {
          return s;
        }
      }
    };
    result = pr + this.seed(parseInt(new Date().getTime() / 1000, 10), 8) + this.seed(Math.floor(Math.random() * 0x75bcd15) + 1, 5);
    if (en) {
      result += (Math.random() * 10).toFixed(8).toString();
    }
    return result;
  };
  return this.isInt = function(str) {
    return !/\D/.test(str);
  };
})();

FormHelper = (function() {
  function FormHelper() {}

  FormHelper.prototype.SetValue = function(key, val) {
    var $field;
    $field = $('#book-editor #' + key);
    if ($field.length > 0) {
      $field.val(val);
    }
    return null;
  };

  FormHelper.prototype.GetValue = function(field) {
    return $('#book-editor #' + field).val();
  };

  FormHelper.prototype.GetJson = function() {
    return {
      'author': this.GetValue('author'),
      'year': this.GetValue('year'),
      'title': this.GetValue('title'),
      'countPages': this.GetValue('countPages')
    };
  };

  FormHelper.prototype.Reset = function() {
    $('.btn-reset').trigger('click');
    return null;
  };

  FormHelper.prototype.Set = function(json) {
    var key, val;
    for (key in json) {
      val = json[key];
      this.SetValue(key, val);
    }
    return null;
  };

  return FormHelper;

})();

IStorage = (function() {
  function IStorage() {
    this.initStorage();
  }

  IStorage.prototype.initStorage = function() {
    throw false;
  };

  IStorage.prototype.get = function(key) {
    throw false;
  };

  IStorage.prototype.set = function(key, val) {
    throw false;
  };

  IStorage.prototype["delete"] = function(key) {
    throw false;
  };

  IStorage.prototype.getStorage = function() {
    throw false;
  };

  return IStorage;

})();

QLocalStorage = (function(_super) {
  __extends(QLocalStorage, _super);

  function QLocalStorage() {
    return QLocalStorage.__super__.constructor.apply(this, arguments);
  }

  QLocalStorage.prototype.storage = null;

  QLocalStorage.prototype.initStorage = function() {
    var error;
    try {
      this.storage = localStorage;
    } catch (_error) {
      error = _error;
      console.log(error);
    }
    return null;
  };

  QLocalStorage.prototype.getStorage = function() {
    return this.storage;
  };

  QLocalStorage.prototype.get = function(key) {
    return JSON.parse(this.storage.getItem(key));
  };

  QLocalStorage.prototype.set = function(key, val) {
    this.storage.setItem(key, JSON.stringify(val));
    return null;
  };

  QLocalStorage.prototype["delete"] = function(key) {
    this.storage.removeItem(key);
    return null;
  };

  return QLocalStorage;

})(IStorage);

QManager = (function() {
  QManager.prototype.storage = null;

  QManager.prototype.instance = null;

  QManager.prototype.relation = null;

  function QManager() {
    if (this.storage == null) {
      throw false;
    }
    this.relation = new QRelation(this.storage);
    this;
  }

  QManager.prototype.GetRelation = function() {
    return this.relation;
  };

  QManager.prototype.SetStorage = function(IStorage) {
    this.storage = IStorage;
    return null;
  };

  QManager.prototype.GetInstance = function() {
    if (this.instance != null) {
      return this.instance;
    } else {
      this.instance = new this.constructor();
      return this.instance;
    }
  };

  QManager.prototype.Create = function(json) {
    var __id;
    if (this.Validation(json) === true) {
      if (__id = this.relation.newRow()) {
        this.storage.set(__id, json);
        return __id;
      }
    }
    return false;
  };

  QManager.prototype.Read = function(__id) {
    if (this.relation.findById(__id) === true) {
      return this.storage.get(__id);
    }
    return false;
  };

  QManager.prototype.Update = function(__id, json) {
    var row;
    if (this.relation.findById(__id) === false) {
      throw false;
    }
    if (row = this.Read(__id)) {
      if (this.Validation(json, 'update') === true) {
        this.storage.set(__id, json);
        return true;
      }
    }
    return false;
  };

  QManager.prototype.Delete = function(__id) {
    var row;
    if (this.relation.findById(__id) === true && (row = this.Read(__id))) {
      if (this.relation.remove(__id) === true) {
        this.storage["delete"](__id);
        return true;
      }
      return false;
    }
    return false;
  };

  QManager.prototype.Validation = function(json, scenario) {
    var e;
    try {
      new QValidation(json, scenario);
      return true;
    } catch (_error) {
      e = _error;
      alert(e);
      return false;
    }
  };

  QManager.prototype.Count = function() {
    return this.relation.getCount();
  };

  QManager.prototype.Search = function(key, val) {
    var item, row, _i, _len, _ref;
    if (!(this.Count() > 0)) {
      return null;
    }
    _ref = this.relation.getRelation();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      if (row = this.Read(item)) {
        if (row[key] === val) {
          return item;
        }
      }
    }
    return null;
  };

  return QManager;

})();

QRelation = (function() {
  QRelation.prototype.storage = null;

  QRelation.prototype.KEY = 'relation';

  function QRelation(_at_storage) {
    this.storage = _at_storage;
    if (this.storage.get(this.KEY) == null) {
      this.storage.set(this.KEY, []);
    }
  }

  QRelation.prototype.getRelation = function() {
    var relation;
    relation = this.storage.get(this.KEY);
    if ((relation == null) || relation.length === 0) {
      relation = [];
    }
    if (relation.length !== 0) {
      relation = relation;
    }
    return relation;
  };

  QRelation.prototype.newRow = function() {
    var relation, __id;
    __id = uniqid('book_');
    relation = this.getRelation();
    relation.push(__id);
    this.storage.set(this.KEY, relation);
    return __id;
  };

  QRelation.prototype.findById = function(__id) {
    var relation;
    if (relation = this.storage.get(this.KEY)) {
      return __indexOf.call(relation, __id) >= 0;
    }
    return false;
  };

  QRelation.prototype.remove = function(__id) {
    var item, relation, __relation, _i, _len;
    if (this.findById(__id) === true) {
      relation = this.getRelation();
      __relation = [];
      for (_i = 0, _len = relation.length; _i < _len; _i++) {
        item = relation[_i];
        if (item !== __id) {
          __relation.push(item);
        }
      }
      this.storage.set(this.KEY, __relation);
      return true;
    }
    return false;
  };

  QRelation.prototype.getCount = function() {
    return this.getRelation().length;
  };

  return QRelation;

})();

QValidation = (function() {
  QValidation.prototype.json = null;

  QValidation.prototype.scenario = null;

  function QValidation(_at_json, _at_scenario) {
    this.json = _at_json;
    this.scenario = _at_scenario != null ? _at_scenario : 'create';
    if (this.json == null) {
      throw 'Необходимо заполнить форму';
    }
    this.existsFields();
    this.requireNumericFields();
    if (this.scenario === 'create') {
      this.uniqueFields();
    }
    return this;
  }

  QValidation.prototype.existsFields = function() {
    if (!((this.json.author != null) && this.json.author.length > 0)) {
      throw 'Необходимо указать автора';
    }
    if (!((this.json.title != null) && this.json.title.length > 0)) {
      throw 'Необходимо указать название';
    }
    if (!((this.json.year != null) && this.json.year.length > 0)) {
      throw 'Необходимо указать год';
    }
    if (!((this.json.countPages != null) && this.json.countPages.length > 0)) {
      throw 'Необходимо указать количество страниц';
    }
    return null;
  };

  QValidation.prototype.requireNumericFields = function() {
    if (isInt(this.json.year) !== true) {
      throw 'Поле "год", должно состоять только из цифр';
    }
    if (isInt(this.json.countPages) !== true) {
      throw 'Поле "Количество страниц", должно состоять только из цифр';
    }
    return null;
  };

  QValidation.prototype.uniqueFields = function() {
    if (QManager.prototype.GetInstance().Search('title', this.json.title) !== null) {
      throw 'Книга с таким именем уже существует';
    }
    return null;
  };

  return QValidation;

})();

QList = (function() {
  function QList() {}

  QList.prototype.GetTemplate = function() {
    return $('div#templates .table-tr tr').clone();
  };

  QList.prototype.Fill = function() {
    var Relations, __id, _i, _len, _ref;
    Relations = QManager.prototype.GetInstance().GetRelation().getRelation();
    _ref = Relations.reverse();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      __id = _ref[_i];
      this.PushItem(__id);
    }
    this.CheckEmpty();
    return null;
  };

  QList.prototype.PushItem = function(__id) {
    var $tr, row;
    row = QManager.prototype.GetInstance().Read(__id);
    $tr = this.GetTemplate();
    $tr.find('.author').text(row.author);
    $tr.find('.title').text(row.title);
    $tr.attr('bid', __id);
    $('.list-book tbody').append($tr);
    return null;
  };

  QList.prototype.Empty = function() {
    $('.list-book tbody tr.item').remove();
    return null;
  };

  QList.prototype.Reload = function() {
    this.Empty();
    this.Fill();
    this.CheckEmpty();
    return null;
  };

  QList.prototype.CheckEmpty = function() {
    if (QManager.prototype.GetInstance().Count() === 0) {
      $('.empty-list').show();
    } else {
      $('.empty-list').hide();
    }
    return null;
  };

  return QList;

})();

$(function() {
  var qls;
  qls = new QLocalStorage();
  QManager.prototype.SetStorage(qls);
  QList.prototype.Fill();
  $('.list-book').on('click', '.btn-edit', function(e) {
    var $tr, T, json, __id;
    T = $(e.currentTarget);
    $tr = T.parents('tr:first');
    __id = $tr.attr('bid');
    if (json = QManager.prototype.GetInstance().Read(__id)) {
      FormHelper.prototype.Set(json);
      $('.btn-update').show();
      $('.btn-create').hide();
      $('.btn-update').attr('bid', __id);
    }
    return null;
  });
  $('.list-book').on('click', '.btn-remove', function(e) {
    var $tr, T, bid, __id;
    if (confirm('Точно удалить?') === true) {
      T = $(e.currentTarget);
      $tr = T.parents('tr:first');
      __id = $tr.attr('bid');
      if (QManager.prototype.GetInstance().Delete(__id) === true) {
        QList.prototype.Reload();
        if (bid = $('.btn-update').attr('bid')) {
          if (bid === __id) {
            FormHelper.prototype.Reset();
          }
        }
      }
    }
    return null;
  });
  $('.btn-reset').click(function(e) {
    $('.btn-update').hide();
    $('.btn-create').show();
    $('.btn-update').removeAttr('bid');
    return null;
  });
  $('.btn-create').click(function(e) {
    if (QManager.prototype.GetInstance().Create(FormHelper.prototype.GetJson()) !== false) {
      QList.prototype.Reload();
      FormHelper.prototype.Reset();
    }
    return null;
  });
  $('.btn-update').click(function(e) {
    var T, __id;
    T = $(e.currentTarget);
    __id = T.attr('bid');
    if (QManager.prototype.GetInstance().Update(__id, FormHelper.prototype.GetJson()) === true) {
      QList.prototype.Reload();
    }
    return null;
  });
});
