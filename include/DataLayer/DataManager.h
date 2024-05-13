#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QDebug>
#include <QString>
#include <QTimer>

#include "Item.h"

using namespace std;

class DataManager : public QObject
{
  Q_OBJECT

public:

  // Constructor
  DataManager();

  // Destuctor
  ~DataManager();

  // List accesible from QML
  Q_PROPERTY(QList<QObject *> itemList READ itemList NOTIFY itemListChanged)
  QList<QObject *> itemList()
  {
      return _qml_item_list;
  }

  // Getter to get by key and directly from items map
  Q_INVOKABLE QObject* getItem(QString key);

  // Timer callback
  void update();

signals:

  void itemListChanged();

private:

  ItemMap _item_map;
  QList<QObject *> _qml_item_list;

  // Timer
  QTimer *_timer;
};

#endif // DATAMANAGER_H
