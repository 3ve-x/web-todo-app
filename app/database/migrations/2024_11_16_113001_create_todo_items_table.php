<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Models\User;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('todo_items', function (Blueprint $table) {
            $table->id();

						// ここから追加
            $table->foreignId('user_id') // 外部キーを追加
                ->constrained()
                ->cascadeOnUpdate()
                ->cascadeOnDelete();
            $table->text('title');
            $table->boolean('is_done')->default(false);
            // ここまで追加

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('todo_items');
    }
};