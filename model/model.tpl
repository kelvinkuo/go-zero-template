package {{.pkg}}
{{if .withCache}}
import (
	"github.com/zeromicro/go-zero/core/stores/cache"
	"github.com/zeromicro/go-zero/core/stores/sqlx"
)
{{else}}

import "github.com/zeromicro/go-zero/core/stores/sqlx"
{{end}}
var _ {{.upperStartCamelObject}}Model = (*custom{{.upperStartCamelObject}}Model)(nil)

type (
	// {{.upperStartCamelObject}}Model is an interface to be customized, add more methods here,
	// and implement the added methods in custom{{.upperStartCamelObject}}Model.
	{{.upperStartCamelObject}}Model interface {
		{{.lowerStartCamelObject}}Model
		DeleteSoft(ctx context.Context, session sqlx.Session, data *HomestayOrder) error
		// Trans(ctx context.Context, fn func(context context.Context, session sqlx.Session) error) error
		// RowBuilder() squirrel.SelectBuilder
		// CountBuilder(field string) squirrel.SelectBuilder
		// SumBuilder(field string) squirrel.SelectBuilder
		// FindOneByQuery(ctx context.Context, rowBuilder squirrel.SelectBuilder) (*HomestayOrder, error)
		// FindSum(ctx context.Context, sumBuilder squirrel.SelectBuilder) (float64, error)
		// FindCount(ctx context.Context, countBuilder squirrel.SelectBuilder) (int64, error)
		// FindAll(ctx context.Context, rowBuilder squirrel.SelectBuilder, orderBy string) ([]*HomestayOrder, error)
		// FindPageListByPage(ctx context.Context, rowBuilder squirrel.SelectBuilder, page, pageSize int64, orderBy string) ([]*HomestayOrder, error)
		// FindPageListByIdDESC(ctx context.Context, rowBuilder squirrel.SelectBuilder, preMinId, pageSize int64) ([]*HomestayOrder, error)
		// FindPageListByIdASC(ctx context.Context, rowBuilder squirrel.SelectBuilder, preMaxId, pageSize int64) ([]*HomestayOrder, error)
	}

	custom{{.upperStartCamelObject}}Model struct {
		*default{{.upperStartCamelObject}}Model
	}
)

// New{{.upperStartCamelObject}}Model returns a model for the database table.
func New{{.upperStartCamelObject}}Model(conn sqlx.SqlConn{{if .withCache}}, c cache.CacheConf, opts ...cache.Option{{end}}) {{.upperStartCamelObject}}Model {
	return &custom{{.upperStartCamelObject}}Model{
		default{{.upperStartCamelObject}}Model: new{{.upperStartCamelObject}}Model(conn{{if .withCache}}, c, opts...{{end}}),
	}
}

// DeleteSoft set deleted_at with CURRENT_TIMESTAMP
func (m *default{{.upperStartCamelObject}}Model) DeleteSoft(ctx context.Context, session sqlx.Session, data *{{.upperStartCamelObject}}) error {
	data.DeletedAt = time.Now()
	if err := m.Update(ctx, session, data); err != nil {
		return errors.Wrapf(xerr.NewErrMsg("删除数据失败"), "{{.upperStartCamelObject}}Model delete err : %+v", err)
	}
	return nil
}