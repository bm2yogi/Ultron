using System.Collections;
using System.Collections.Generic;

namespace Ultron.DataAccess
{
    public interface IDataStore<T>
    {
        IEnumerable<T> Fetch();
        T Fetch(int id);
        T Save(T entity);
        T Delete(T entity);
    }
}